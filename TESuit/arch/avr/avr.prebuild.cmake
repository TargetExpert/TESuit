#=========================================================================
#
#          File: avr.prebuild.cmake
#
#   Description: Toolchain setting prebuild script for avr achitecture.
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

set(_avr_toolchain_prefix "avr-")
set(_avr_toolchain_root "${CMAKE_SOURCE_DIR}/${_TESuit_Dir_Name}/${_TESuit_toolchains_Dir_Name}/${_TESuit_Target_Arch_Name}/bin")

# C Compiler Path for AVR.
set(CMAKE_C_COMPILER "${_avr_toolchain_root}/${_avr_toolchain_prefix}gcc" CACHE STRING "AVR-GCC C Compiler for AVR" FORCE)
set(CMAKE_CXX_COMPILER "${_avr_toolchain_root}/${_avr_toolchain_prefix}g++" CACHE STRING "AVR-GCC C++ Compiler for AVR" FORCE)
set(CMAKE_C_COMPILER_AR "${_avr_toolchain_root}/${_avr_toolchain_prefix}nr" CACHE STRING "AVR-GCC ar for AVR" FORCE)
set(CMAKE_C_COMPILER_LINKER "${_avr_toolchain_root}/${_avr_toolchain_prefix}ld" CACHE STRING "AVR-GCC linker for AVR" FORCE)
set(CMAKE_C_COMPILER_STRIP "${_avr_toolchain_root}/${_avr_toolchain_prefix}strip" CACHE STRING "AVR-GCC strip for AVR" FORCE)
set(CMAKE_C_COMPILER_RANLIB "${_avr_toolchain_root}/${_avr_toolchain_prefix}ranlib" CACHE STRING "AVR-GCC ranlib for AVR" FORCE)
set(CMAKE_C_COMPILER_NM "${_avr_toolchain_root}/${_avr_toolchain_prefix}nm" CACHE STRING "AVR-GCC nm for AVR8" FORCE)

string(REPLACE "-Wl,-search_paths_first" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
string(REPLACE "-Wl,-search_paths_first" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")

string(REPLACE "-Wl,-search_paths_first" "" CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS}")
string(REPLACE "-Wl,-search_paths_first" "" CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS}")

set(_avr_mcu_spec "-mmcu=${_TESuit_Target}")
set(_avr_mcu_freq "-DF_CPU=${_TESuit_Target_Freq}")
set(_avr_std "-std=${_TESuit_LangStdTypeParm}${_TESuit_LangStdYear}")

set(_avr_c_flag_opt "${_avr_mcu_spec} ${_avr_mcu_freq} ${_avr_std} ${_TESuit_C_Flags_Opt} -w -Os -g -flto -fuse-linker-plugin -Wl,--gc-sections")
set(_avr_cxx_flag_opt "${_avr_mcu_spec} ${_avr_mcu_freq} ${_avr_std} ${_TESuit_CXX_Flags_Opt} -w -Os -g -flto -fuse-linker-plugin -Wl,--gc-sections")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${_avr_c_flag_opt} --save-temps" PARENT_SCOPE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${_avr_cxx_flag_opt} --save-temps" PARENT_SCOPE)
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS}" PARENT_SCOPE)
set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS}" PARENT_SCOPE)