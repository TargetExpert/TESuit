#=========================================================================
#
#          File: TEPrebuild.cmake
#
#   Description: Prebuild function for easy settings of prebuild
#                instructions
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

function(TE_Prebuild)
	include(${CMAKE_CURRENT_LIST_DIR}/TESuit/prebuild/TEAutoInc.cmake)

	TE_AutoInc(./TargetExpert ".c;.cpp;.h;.hpp;.cc")

	include(${CMAKE_CURRENT_LIST_DIR}/TESuit/arch/avr8.prebuild.cmake)

	set(TE_src_files ${TE_src_files} PARENT_SCOPE)
	set(TE_src_directories ${TE_src_directories} PARENT_SCOPE)

	include_directories(./)
	include_directories(${TE_src_directories})
endfunction()