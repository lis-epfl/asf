
/**
 * \file
 *
 * \brief Find Me Target Profile
 *
 * Copyright (c) 2015 Atmel Corporation. All rights reserved.
 *
 * \asf_license_start
 *
 * \page License
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. The name of Atmel may not be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * 4. This software may only be redistributed and used in connection with an
 *    Atmel microcontroller product.
 *
 * THIS SOFTWARE IS PROVIDED BY ATMEL "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT ARE
 * EXPRESSLY AND SPECIFICALLY DISCLAIMED. IN NO EVENT SHALL ATMEL BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * \asf_license_stop
 *
 */
/*
 * Support and FAQ: visit <a href="http://www.atmel.com/design-support/">Atmel
 * Support</a>
 */

/****************************************************************************************
*							        Includes	                                     	*
****************************************************************************************/
#include <asf.h>

#include "timer_hw.h"
#include "ble_manager.h"
#include "find_me_target.h"
#include "immediate_alert.h"


/****************************************************************************************
*							        Globals	                                     		*
****************************************************************************************/

/* Immediate alert service declaration */
#ifdef IMMEDIATE_ALERT_SERVICE
gatt_service_handler_t ias_handle;
#endif

/** @brief Scan response data*/
uint8_t scan_rsp_data[SCAN_RESP_LEN]
	= {0x09, 0xff, 0x00, 0x06, 0xd6, 0xb2, 0xf0, 0x05, 0xf0, 0xf8};

/** @brief Alert value used for immediate alert service */
uint8_t immediate_alert_value = INVALID_IAS_PARAM;

/** @brief Callback handlers for Immediate Alert service */
find_me_callback_t immediate_alert_cb;

/****************************************************************************************
*							        Implementation	                                    *
****************************************************************************************/

/**
 * \brief registering the path loss handler of the application
 */
void register_find_me_handler(find_me_callback_t immediate_alert_fn)
{
	immediate_alert_cb = immediate_alert_fn;
}

/**
 * \brief Initializations of find me profile services
 */
void fmp_target_service_init(void)
{
	/** Initializing the mandatory immediate alert service of find me
	 *profile*/
	init_immediate_alert_service(&ias_handle);
}

/**
 * \Definition of profile immediate alert services to the attribute data base
 */
at_ble_status_t fmp_target_service_define(void)
{
	ias_primary_service_define(&ias_handle);
	DBG_LOG("The Supported Services in Find Me Profile are:");
	DBG_LOG("  -> Immediate Alert Service");
	return AT_BLE_SUCCESS;
}

/**
 * \find me advertisement initialization and adv start
 */
void fmp_target_adv(void)
{
	uint8_t idx = 0;
	uint8_t adv_data [ FMP_ADV_DATA_NAME_LEN + IAL_ADV_DATA_UUID_LEN   +
	(2 * 2)];

	adv_data[idx++] = ADV_TYPE_LEN + IAL_ADV_DATA_UUID_LEN;
	adv_data[idx++] = IAL_ADV_DATA_UUID_TYPE;

	#ifdef IMMEDIATE_ALERT_SERVICE
	/* Prepare ADV Data for IAS Service */
	adv_data[idx++] = (uint8_t)IMMEDIATE_ALERT_SERVICE_UUID;
	adv_data[idx++] = (uint8_t)(IMMEDIATE_ALERT_SERVICE_UUID >> 8);
	#endif

	/* Appending the complete name to the Ad packet */
	adv_data[idx++] = FMP_ADV_DATA_NAME_LEN + ADV_TYPE_LEN;
	adv_data[idx++] = FMP_ADV_DATA_NAME_TYPE;

	memcpy(&adv_data[idx], FMP_ADV_DATA_NAME_DATA, FMP_ADV_DATA_NAME_LEN );
	idx += FMP_ADV_DATA_NAME_LEN;

	/* Adding the advertisement data and scan response data */
	if (!(at_ble_adv_data_set(adv_data, idx, scan_rsp_data,
			SCAN_RESP_LEN) == AT_BLE_SUCCESS)) {
		#ifdef DBG_LOG
		DBG_LOG("Failed to set adv data");
		#endif
	}

	/* Start of advertisement */
	if (at_ble_adv_start(AT_BLE_ADV_TYPE_UNDIRECTED,
			AT_BLE_ADV_GEN_DISCOVERABLE, NULL, AT_BLE_ADV_FP_ANY,
			APP_FMP_FAST_ADV, APP_FMP_ADV_TIMEOUT,
			0) == AT_BLE_SUCCESS) {
		#ifdef DBG_LOG
		DBG_LOG("Bluetooth device is in Advertising Mode");
		#endif
	} else {
		#ifdef DBG_LOG
		DBG_LOG("BLE Adv start Failed");
		#endif
	}
}

/**
 * \Immediate alert service characteristic change handler function
 */
at_ble_status_t fmp_target_char_changed_handler(
		at_ble_characteristic_changed_t *char_handle)
{
	at_ble_characteristic_changed_t change_params;
	memcpy((uint8_t *)&change_params, char_handle,
			sizeof(at_ble_characteristic_changed_t));

	immediate_alert_value
		= ias_set_alert_value(&change_params, &ias_handle);

	if (immediate_alert_value != INVALID_IAS_PARAM) {
		immediate_alert_cb(immediate_alert_value);
	}

	return AT_BLE_SUCCESS;
}

/**
 * \Find me profile connected state handler function
 */
at_ble_status_t fmp_target_connected_state_handler(
		at_ble_connected_t *conn_params)
{
	at_ble_status_t status;
	uint16_t len;
	
	///* Upon connection set default value to no alert*/
	//immediate_alert_cb(IAS_NO_ALERT);
	
	if ((status
				= at_ble_characteristic_value_get(ias_handle.
					serv_chars.char_val_handle,
					&immediate_alert_value,
					&len))) {
		DBG_LOG(
				"Read of alert value for Immediate alert service failed:reason %x",
				status);
	}
        ALL_UNUSED(conn_params);
	return AT_BLE_SUCCESS;
}

/**
 * \Find me profile disconnected state handler function
 */
at_ble_status_t fmp_target_disconnect_event_handler(
		at_ble_disconnected_t *disconnect)
{
	if (at_ble_adv_start(AT_BLE_ADV_TYPE_UNDIRECTED,
			AT_BLE_ADV_GEN_DISCOVERABLE, NULL, AT_BLE_ADV_FP_ANY,
			APP_FMP_FAST_ADV, APP_FMP_ADV_TIMEOUT,
			0) != AT_BLE_SUCCESS) {
		#ifdef DBG_LOG
		DBG_LOG("BLE Adv start Failed");
		#endif
	} else {
		DBG_LOG("Bluetooth Device is in Advertising Mode");
	}
        ALL_UNUSED(disconnect);
	return AT_BLE_SUCCESS;
}


/**
 * \Find me Profile service initialization, declarations and advertisement
 */
void fmp_target_init(void *param)
{
	/* find me services initialization*/
	fmp_target_service_init();

	/* find me services definition    */
	fmp_target_service_define();

	/* find me services advertisement */
	fmp_target_adv();
        ALL_UNUSED(param);
}
