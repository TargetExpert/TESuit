#=========================================================================
#
#          File: TEVars.cmake
#
#   Description: Set of Global Variables.
#
#        Author: Doohoon Kim (Gabriel Kim, invi.dh.kim@gmail.com)
#
#       Created: 2019/09/19
#
#  Copyright (c) 2019, TargetExpert Project is Gabriel Kim(Doohoon Kim),
#  All rights reserved.
#
#  ** The "TargetExpert" is distributed under the "3-clause BSD" license.
#     See details COPYING.
#
#=========================================================================

# Internal variables.
function(_Set_Int_DirVars)
	set(_TESuit_Project_Root_Dir ${CMAKE_SOURCE_DIR} PARENT_SCOPE)

	set(_TargetExpert_Dir_Name "TargetExpert" PARENT_SCOPE)

	set(_TargetExpert_Src_Dir_name "src" PARENT_SCOPE)
	set(_TargetExpert_LLL_Dir_name "LLL" PARENT_SCOPE)
	set(_TargetExpert_MLL_Dir_name "MLL" PARENT_SCOPE)
	set(_TargetExpert_HLL_Dir_name "HLL" PARENT_SCOPE)

	set(_TESuit_Dir_Name "TESuit" PARENT_SCOPE)

	set(_TESuit_arch_Dir_Name "arch" PARENT_SCOPE)
	set(_TESuit_init_Dir_Name "init" PARENT_SCOPE)
	set(_TESuit_prebuild_Dir_Name "prebuild" PARENT_SCOPE)
	set(_TESuit_inbuild_Dir_Name "inbuild" PARENT_SCOPE)
	set(_TESuit_postbuild_Dir_Name "postbuild" PARENT_SCOPE)
	set(_TESuit_toolchains_Dir_Name "toolchains" PARENT_SCOPE)
endfunction()

function(_Set_Int_LangStdTypeVars)
	# for Options Controlling C Dialect.
	# https://gcc.gnu.org/onlinedocs/gcc-3.4.1/gcc/C-Dialect-Options.html

	set(_TESuit_LangType "" PARENT_SCOPE)
	set(_TESuit_LangStdType "" PARENT_SCOPE)
	set(_TESuit_LangStdTypeParm "" PARENT_SCOPE)
	set(_TESuit_LangStdYear "" PARENT_SCOPE)
endfunction()

function(_Set_Int_CompOptVars)
	set(_TESuit_C_Flags_Opt "" PARENT_SCOPE)
	set(_TESuit_CXX_Flags_Opt "" PARENT_SCOPE)
	set(_TESuit_C_Link_Flags_Opt "" PARENT_SCOPE)
	set(_TESuit_CXX_Link_Flags_Opt "" PARENT_SCOPE)
endfunction()

function(_Set_Int_ArchVars)
	set(_TESuit_Target_Arch_Name "" PARENT_SCOPE)
endfunction()

function(_Set_Int_DeviceVars)
	# It's 'machine name' of you will jointing a 'Target Processor or Controller'.
	set(_TESuit_Target "" PARENT_SCOPE)
	# It's 'frequency value' of you will jointing a 'Target Processor or Controller'.
	set(_TESuit_Target_Freq "" PARENT_SCOPE)
	# It's 'interface device name' of you will jointing a 'Target Processor or Controller'.
	# Windows is not supported yet.
	set(_TESuit_Joint_Interface "" PARENT_SCOPE)
	# It's port of 'interfacing device' of you will jointing a 'Target Processor or Controller'.
	# you'll check following this command..
	# (* on *nix)
	#  $ ls /dev
	# (* on Windows)
	# It's not supported yet.
	set(_TESuit_Joint_Port "" PARENT_SCOPE)
endfunction()

# External variables.
function(_Set_Ext_ProjectVars)
	set(Project_Name "" PARENT_SCOPE)
	set(Language "" PARENT_SCOPE)
endfunction()

_Set_Int_DirVars()
_Set_Int_LangStdTypeVars()
_Set_Int_CompOptVars()
_Set_Int_ArchVars()
_Set_Int_DeviceVars()

_Set_Ext_ProjectVars()
