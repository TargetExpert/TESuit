#=========================================================================
#
#          File: avr.postbuild.cmake
#
#   Description: Toolchain setting postbuild script for avr8 achitecture.
#                (for ISP)
#
#        Author: Doohoon Kim (Gabriel Kim, invi.dh.kim@gmail.com)
#
#       Created: 2019/09/18
#
#  Copyright (c) 2019, TargetExpert Project is Gabriel Kim(Doohoon Kim),
#  All rights reserved.
#
#  ** The "TargetExpert" is distributed under the "3-clause BSD" license.
#     See details COPYING.
#
#=========================================================================

add_custom_command(TARGET ${PROJECT_NAME}
		POST_BUILD COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/TESuit/toolchains/avr/bin/avr-objcopy
		-O ihex -R.eeprom
		${CMAKE_CURRENT_SOURCE_DIR}/cmake-build-debug/${PROJECT_NAME}
		${CMAKE_CURRENT_SOURCE_DIR}/cmake-build-debug/${PROJECT_NAME}.hex)
add_custom_command(TARGET ${PROJECT_NAME}
		POST_BUILD COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/TESuit/toolchains/avr/bin/avr-objcopy
		-O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0
		${CMAKE_CURRENT_SOURCE_DIR}/cmake-build-debug/${PROJECT_NAME}
		${CMAKE_CURRENT_SOURCE_DIR}/cmake-build-debug/${PROJECT_NAME}.eep)
add_custom_command(TARGET ${PROJECT_NAME}
		POST_BUILD COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/TESuit/toolchains/avr/bin/avr-size
		${CMAKE_CURRENT_SOURCE_DIR}/cmake-build-debug/${PROJECT_NAME}
		-C --mcu=${TARGET} --format=avr)
add_custom_command(TARGET ${PROJECT_NAME}
		POST_BUILD COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/TESuit/toolchains/avr/bin/avrdude
		-C${CMAKE_CURRENT_SOURCE_DIR}/TESuit/toolchains/avr/etc/avrdude.conf
		-v -p${TARGET} -c${DEBUGGER_TYPE} -P${DEBUGGER_PORT} -b115200
		-D -Uflash:w:${PROJECT_NAME}.hex:i)