#=========================================================================
#
#          File: avr.postbuild.cmake
#
#   Description: Toolchain setting postbuild script for avr achitecture.
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
		POST_BUILD COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/${_TESuit_Dir_Name}/${_TESuit_toolchains_Dir_Name}/${_TESuit_Target_Arch_Name}/bin/avr-objcopy
		-O ihex -R.eeprom
		${CMAKE_CURRENT_SOURCE_DIR}/cmake-build-debug/${PROJECT_NAME}
		${CMAKE_CURRENT_SOURCE_DIR}/cmake-build-debug/${PROJECT_NAME}.hex)
add_custom_command(TARGET ${PROJECT_NAME}
		POST_BUILD COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/${_TESuit_Dir_Name}/${_TESuit_toolchains_Dir_Name}/${_TESuit_Target_Arch_Name}/bin/avr-objcopy
		-O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0
		${CMAKE_CURRENT_SOURCE_DIR}/cmake-build-debug/${PROJECT_NAME}
		${CMAKE_CURRENT_SOURCE_DIR}/cmake-build-debug/${PROJECT_NAME}.eep)
add_custom_command(TARGET ${PROJECT_NAME}
		POST_BUILD COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/${_TESuit_Dir_Name}/${_TESuit_toolchains_Dir_Name}/${_TESuit_Target_Arch_Name}/bin/avr-size
		${CMAKE_CURRENT_SOURCE_DIR}/cmake-build-debug/${PROJECT_NAME}
		-C --mcu=${_TESuit_Target} --format=${_TESuit_Target_Arch_Name})
add_custom_command(TARGET ${PROJECT_NAME}
		POST_BUILD COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/${_TESuit_Dir_Name}/${_TESuit_toolchains_Dir_Name}/${_TESuit_Target_Arch_Name}/bin/avrdude
		-C${CMAKE_CURRENT_SOURCE_DIR}/${_TESuit_Dir_Name}/${_TESuit_toolchains_Dir_Name}/${_TESuit_Target_Arch_Name}/etc/avrdude.conf
		-v -p${_TESuit_Target} -c${_TESuit_Joint_Interface} -P${_TESuit_Joint_Port} -b115200
		-D -Uflash:w:${PROJECT_NAME}.hex:i)