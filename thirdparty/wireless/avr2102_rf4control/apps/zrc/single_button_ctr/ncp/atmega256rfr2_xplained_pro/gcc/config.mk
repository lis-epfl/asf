#
# Copyright (c) 2010 Atmel Corporation. All rights reserved.
#
# \asf_license_start
#
# \page License
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# 3. The name of Atmel may not be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# 4. This software may only be redistributed and used in connection with an
#    Atmel microcontroller product.
#
# THIS SOFTWARE IS PROVIDED BY ATMEL "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT ARE
# EXPRESSLY AND SPECIFICALLY DISCLAIMED. IN NO EVENT SHALL ATMEL BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# \asf_license_stop
#

# Path to top level ASF directory relative to this project directory.
PRJ_PATH = ../../../../../../../../..

# Microcontroller: atxmega128a1, atmega128, attiny261, etc.
MCU = atmega256rfr2

# Application target name. Given with suffix .a for library and .elf for a
# standalone application.
TARGET = single_button_ctr_ncp.elf

# C source files located from the top-level source directory
CSRCS = \
       common/services/clock/mega/sysclk.c                \
       common/services/serial/usart_serial.c              \
       common/services/sleepmgr/mega/sleepmgr.c           \
       common/utils/stdio/read.c                          \
       common/utils/stdio/write.c                         \
       mega/boards/atmega256rfr2_xplained_pro/init.c      \
       mega/drivers/ext_int/ext_int_megarf.c              \
       mega/drivers/macsc/macsc_megarf.c                  \
       mega/drivers/usart/usart_megarf.c                  \
       thirdparty/wireless/addons/sio2host/uart/sio2host.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_associate.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_beacon.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_data_extract_mhr.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_data_ind.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_data_req.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_disassociate.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_dispatcher.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_gts.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_mcps_data.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_misc.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_orphan.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_pib.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_poll.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_process_beacon_frame.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_process_tal_tx_frame_status.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_rx_enable.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_scan.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_security.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_start.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_sync.c \
       thirdparty/wireless/avr2025_mac/source/mac/src/mac_tx_coord_realignment_command.c \
       thirdparty/wireless/avr2025_mac/source/pal/common/drivers/nvm/mega/mega_nvm.c \
       thirdparty/wireless/avr2025_mac/source/pal/common_sw_timer/common_sw_timer.c \
       thirdparty/wireless/avr2025_mac/source/pal/pal.c   \
       thirdparty/wireless/avr2025_mac/source/resources/buffer/src/bmm.c \
       thirdparty/wireless/avr2025_mac/source/resources/queue/src/qmm.c \
       thirdparty/wireless/avr2025_mac/source/stb/src/stb.c \
       thirdparty/wireless/avr2025_mac/source/stb/src/stb_armcrypto.c \
       thirdparty/wireless/avr2025_mac/source/stb/src/stb_help.c \
       thirdparty/wireless/avr2025_mac/source/tal/atmegarfr2/src/tal.c \
       thirdparty/wireless/avr2025_mac/source/tal/atmegarfr2/src/tal_ed.c \
       thirdparty/wireless/avr2025_mac/source/tal/atmegarfr2/src/tal_init.c \
       thirdparty/wireless/avr2025_mac/source/tal/atmegarfr2/src/tal_irq_handler.c \
       thirdparty/wireless/avr2025_mac/source/tal/atmegarfr2/src/tal_pib.c \
       thirdparty/wireless/avr2025_mac/source/tal/atmegarfr2/src/tal_pwr_mgmt.c \
       thirdparty/wireless/avr2025_mac/source/tal/atmegarfr2/src/tal_rx.c \
       thirdparty/wireless/avr2025_mac/source/tal/atmegarfr2/src/tal_rx_enable.c \
       thirdparty/wireless/avr2025_mac/source/tal/atmegarfr2/src/tal_slotted_csma.c \
       thirdparty/wireless/avr2025_mac/source/tal/atmegarfr2/src/tal_tx.c \
       thirdparty/wireless/avr2025_mac/source/tal/src/tal_helper.c \
       thirdparty/wireless/avr2025_mac/source/tfa/atmegarfr2/src/tfa.c \
       thirdparty/wireless/avr2102_rf4control/apps/zrc/single_button_ctr/main.c \
       thirdparty/wireless/avr2102_rf4control/apps/zrc/single_button_ctr/vendor_data.c \
       thirdparty/wireless/services/common_hw_timer/mega/hw_timer.c \
       thirdparty/wireless/services/mega/drivers/flash/flash.c \
       thirdparty/wireless/services/mega/drivers/tc/tc_megarf.c \
       thirdparty/wireless/services/sal/atmegarf_sal/src/sal.c \
       thirdparty/wireless/services/sleep_mgr/megarf/sleep_mgr.c

# Assembler source files located from the top-level source directory
ASSRCS = 

# Include path located from the top-level source directory
INC_PATH = \
       common/boards                                      \
       common/services/clock                              \
       common/services/delay                              \
       common/services/gpio                               \
       common/services/ioport                             \
       common/services/serial                             \
       common/services/serial/megarf_usart                \
       common/services/sleepmgr                           \
       common/utils                                       \
       common/utils/stdio/stdio_serial                    \
       mega/boards                                        \
       mega/boards/atmega256rfr2_xplained_pro             \
       mega/drivers/cpu                                   \
       mega/drivers/ext_int                               \
       mega/drivers/macsc                                 \
       mega/drivers/sleep                                 \
       mega/drivers/usart                                 \
       mega/utils                                         \
       mega/utils/preprocessor                            \
       thirdparty/wireless/addons/sio2host/uart           \
       thirdparty/wireless/avr2025_mac/include            \
       thirdparty/wireless/avr2025_mac/source/mac/inc     \
       thirdparty/wireless/avr2025_mac/source/pal         \
       thirdparty/wireless/avr2025_mac/source/pal/common/drivers/nvm \
       thirdparty/wireless/avr2025_mac/source/pal/common_sw_timer \
       thirdparty/wireless/avr2025_mac/source/resources/buffer/inc \
       thirdparty/wireless/avr2025_mac/source/resources/queue/inc \
       thirdparty/wireless/avr2025_mac/source/stb/inc     \
       thirdparty/wireless/avr2025_mac/source/tal/atmegarfr2/inc \
       thirdparty/wireless/avr2025_mac/source/tal/inc     \
       thirdparty/wireless/avr2025_mac/source/tfa/inc     \
       thirdparty/wireless/avr2102_rf4control/apps/zrc/single_button_ctr \
       thirdparty/wireless/avr2102_rf4control/apps/zrc/single_button_ctr/ncp \
       thirdparty/wireless/avr2102_rf4control/apps/zrc/single_button_ctr/ncp/atmega256rfr2_xplained_pro \
       thirdparty/wireless/avr2102_rf4control/include     \
       thirdparty/wireless/avr2102_rf4control/lib/zrc/ctr/config \
       thirdparty/wireless/services/common_hw_timer       \
       thirdparty/wireless/services/common_hw_timer/mega  \
       thirdparty/wireless/services/mega/drivers/flash    \
       thirdparty/wireless/services/mega/drivers/tc       \
       thirdparty/wireless/services/sal/inc               \
       thirdparty/wireless/services/sleep_mgr \
       thirdparty/wireless/avr2102_rf4control/apps/zrc/single_button_ctr/ncp/atmega256rfr2_xplained_pro/gcc

# Library paths from the top-level source directory
LIB_PATH =  \
       thirdparty/wireless/avr2102_rf4control/lib/zrc/ctr/atmega256rfr2/gcc \
       thirdparty/wireless/services/common_hw_timer/mega/lib

# Libraries to link with the project
LIBS =  \
       rf4ce-zrc-controller                               \
       megarfr2_lib_hw_timer                             

# Additional options for debugging. By default the common Makefile.in will
# add -gdwarf-2.
DBGFLAGS = 

# Optimization settings
OPTIMIZATION = -Os

# Extra flags used when creating an EEPROM Intel HEX file. By default the
# common Makefile.in will add -j .eeprom
# --set-section-flags=.eeprom="alloc,load" --change-section-lma .eeprom=0.
EEPROMFLAGS = 

# Extra flags used when creating an Intel HEX file. By default the common
# Makefile.in will add -R .eeprom -R .usb_descriptor_table.
FLASHFLAGS = 

# Extra flags to use when archiving.
ARFLAGS = 

# Extra flags to use when assembling.
ASFLAGS = 

# Extra flags to use when compiling.
CFLAGS = 

# Extra flags to use when preprocessing.
#
# Preprocessor symbol definitions
#   To add a definition use the format "-D name[=definition]".
#   To cancel a definition use the format "-U name".
#
# The most relevant symbols to define for the preprocessor are:
#   BOARD      Target board in use, see boards/board.h for a list.
#   EXT_BOARD  Optional extension board in use, see boards/board.h for a list.
CPPFLAGS = \
       -D BOARD=ATMEGA256RFR2_XPLAINED_PRO                \
       -D ENABLE_PWR_SAVE_MODE                            \
       -D ENABLE_STACK_NVM                                \
       -D ENABLE_TFA                                      \
       -D ENABLE_TRX_SRAM                                 \
       -D HIGHEST_STACK_LAYER=RF4CE                       \
       -D MAC_USER_BUILD_CONFIG                           \
       -D NLDE_HANDLE                                     \
       -D PBP_ORG                                         \
       -D PRIVATE_NIB                                     \
       -D REDUCED_PARAM_CHECK                             \
       -D RF4CE_CALLBACK_PARAM                            \
       -D RF4CE_SECURITY                                  \
       -D RSSI_TO_LQI_MAPPING                             \
       -D SAL_TYPE=ATMEGARF_SAL                           \
       -D SIO_HUB                                         \
       -D STB_ON_SAL                                      \
       -D TAL_TYPE=ATMEGARFR2                             \
       -D TFA_BAT_MON                                     \
       -D VENDOR_DATA                                     \
       -D ZRC_CMD_DISCOVERY                               \
       -D ZRC_PROFILE                                     \
       -D _DEBUG_=0

# Extra flags to use when linking
LDFLAGS =  \
       -Wl,--section-start=.bootloader=0x3f000           

# Pre- and post-build commands
PREBUILD_CMD = 
POSTBUILD_CMD = 