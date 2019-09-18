#=========================================================================
#
#          File: avr8.prebuild.cmake
#
#   Description: Toolchain setting prebuild script for avr8 achitecture.
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
set(_avr_toolchain_root "${CMAKE_SOURCE_DIR}/TESuit/toolchains/avr/bin")

set(CMAKE_C_COMPILER "${_avr_toolchain_root}/${_avr_toolchain_prefix}gcc" CACHE STRING "C Compiler" FORCE)
set(CMAKE_CXX_COMPILER "${_avr_toolchain_root}/${_avr_toolchain_prefix}g++" CACHE STRING "C++ Compiler" FORCE)
set(CMAKE_AR "$${_avr_toolchain_root}/${_avr_toolchain_prefix}nr" CACHE STRING "ar" FORCE)
set(CMAKE_LINKER "${_avr_toolchain_root}/${_avr_toolchain_prefix}ld" CACHE STRING "linker" FORCE)
set(CMAKE_STRIP "${_avr_toolchain_root}/${_avr_toolchain_prefix}strip" CACHE STRING "strip" FORCE)
set(CMAKE_RANLIB "${_avr_toolchain_root}/${_avr_toolchain_prefix}ranlib" CACHE STRING "ranlib" FORCE)
set(CMAKE_NM "${_avr_toolchain_root}/${_avr_toolchain_prefix}nm" CACHE STRING "nm" FORCE)

string(REPLACE "-Wl,-search_paths_first" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
string(REPLACE "-Wl,-search_paths_first" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")

string(REPLACE "-Wl,-search_paths_first" "" CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS}")
string(REPLACE "-Wl,-search_paths_first" "" CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS}")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mmcu=${MCU} -DF_CPU=${F_CPU} -w -Os -g -flto -fuse-linker-plugin -Wl,--gc-sections -std=gnu99 --save-temps" PARENT_SCOPE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mmcu=${MCU} -DF_CPU=${F_CPU} -Os -g -flto -fuse-linker-plugin -Wl,--gc-sections -std=gnu99 --save-temps" PARENT_SCOPE)
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS}" -Os PARENT_SCOPE)
set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS}" -Os PARENT_SCOPE)