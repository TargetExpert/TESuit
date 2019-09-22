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

# including TEAutoInc source for including Source & Directory.
include(${_TESuit_Dir_Name}/${_TESuit_prebuild_Dir_Name}/TEAutoInc.cmake)

function(Prebuild_TE)
	# Find the source for Target LLL.
	_Find_SrcAndDir(${_TargetExpert_Dir_Name} ".c;.cc;.cpp;.h;.hpp")

	include(${_TESuit_Dir_Name}/${_TESuit_arch_Dir_Name}/${_TESuit_Target_Arch_Name}/${_TESuit_Target_Arch_Name}.prebuild.cmake)

	set(TE_src_files ${TE_src_files} PARENT_SCOPE)
	set(TE_src_directories ${TE_src_directories} PARENT_SCOPE)

	include_directories(./)
	include_directories(${TE_src_directories})
endfunction()