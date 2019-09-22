#=========================================================================
#
#          File: TEInit.cmake
#
#   Description: Initialize scripts for Projects Settings.
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

# including TELangOpt source for setting Language options.
include(${_TESuit_Dir_Name}/${_TESuit_init_Dir_Name}/TELangOpt.cmake)
# including TEAutoTarget source for finding Target list.
include(${_TESuit_Dir_Name}/${_TESuit_init_Dir_Name}/TEAutoTarget.cmake)

# External functions.
function(Set_Language_TE lang_type)
	set(__Is_Set_LangOpt true PARENT_SCOPE)

	set(_TESuit_LangType ${lang_type} PARENT_SCOPE)
endfunction()

function(Set_LanguageStd_TE lang_std)
	set(__Is_Set_LangOpt true PARENT_SCOPE)

	set(_TESuit_LangStdType ${lang_std} PARENT_SCOPE)
endfunction()

function(Set_LanguageYear_TE lang_year)
	set(__Is_Set_LangOpt true PARENT_SCOPE)

	set(_TESuit_LangStdYear ${lang_year} PARENT_SCOPE)
endfunction()

function(Set_LangOptAll_TE lang_std lang_type lang_year)
	set(__Is_Set_LangOpt true PARENT_SCOPE)

	_Set_LangOpt(${lang_std} ${lang_type} ${lang_year})

	set(_TESuit_LangType ${_TESuit_LangType} PARENT_SCOPE)
	set(_TESuit_LangStdType ${_TESuit_LangStdType} PARENT_SCOPE)
	set(_TESuit_LangStdYear ${_TESuit_LangStdYear} PARENT_SCOPE)
endfunction()

function(Set_Target target)
	set(__Is_Set_Target true PARENT_SCOPE)

	set(_TESuit_Target ${target} PARENT_SCOPE)
endfunction()

function(Set_TargetFreq frequency)
	set(__Is_Set_Target true PARENT_SCOPE)

	set(_TESuit_Target_Freq ${frequency} PARENT_SCOPE)
endfunction()

function(Set_JointInterface interface_name)
	set(__Is_Set_Target true PARENT_SCOPE)

	set(_TESuit_Joint_Interface ${interface_name} PARENT_SCOPE)
endfunction()

function(Set_JointPort port)
	set(__Is_Set_Target true PARENT_SCOPE)

	set(_TESuit_Joint_Port ${port} PARENT_SCOPE)
endfunction()

# The "TE_Init" function is called after all other "External functions" have been called.
function(Init_TE)
	if (__Is_Set_LangOpt)
		_Analysis_LangOpt()
	else()
		_Set_ForceLangOpt()
	endif()

	if(__Is_Set_Target)
		# Find the source for Target LLL.
		_Find_Target(${_TESuit_Dir_Name}/${_TESuit_arch_Dir_Name} ".folist")
#	else()
#		message(FATAL_ERROR "Please, Set the your \"Target Device\" and \"Target Interface\".")
	endif()

	if(_TESuit_LangType STREQUAL "c")
		set(CMAKE_C_STANDARD ${_TESuit_LangStdYear} PARENT_SCOPE)
	elseif(_TESuit_LangType STREQUAL "c++")
		set(CMAKE_CXX_STANDARD ${_TESuit_LangStdYear} PARENT_SCOPE)
	endif()

	# Syntax for Applying as Global Variables for Lang Options.
	set(_TESuit_LangType ${_TESuit_LangType} PARENT_SCOPE)
	set(_TESuit_LangStdType ${_TESuit_LangStdType} PARENT_SCOPE)
	set(_TESuit_LangStdTypeParm ${_TESuit_LangStdTypeParm} PARENT_SCOPE)
	set(_TESuit_LangStdYear ${_TESuit_LangStdYear} PARENT_SCOPE)

	set(_TESuit_Target_Arch_Name ${_TESuit_Target_Arch_Name} PARENT_SCOPE)
endfunction()