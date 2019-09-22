#=========================================================================
#
#          File: TELangOpt.cmake
#
#   Description: Settings functions set for Options Controlling C Dialect.
#
#        Author: Doohoon Kim (Gabriel Kim, invi.dh.kim@gmail.com)
#
#       Created: 2019/09/22
#
#  Copyright (c) 2019, TargetExpert Project is Gabriel Kim(Doohoon Kim),
#  All rights reserved.
#
#  ** The "TargetExpert" is distributed under the "3-clause BSD" license.
#     See details COPYING.
#
#=========================================================================

function(_Set_ForceLangOpt)
	# Force Settings with gnu99(C99).
	if(_TESuit_LangType STREQUAL "")
		set(_TESuit_LangType "c" PARENT_SCOPE)
	endif()

	if(_TESuit_LangStdType STREQUAL "")
		set(_TESuit_LangStdTypeParm "gnu" PARENT_SCOPE)
	endif()

	if(_TESuit_LangStdYear STREQUAL "")
		set(_TESuit_LangStdYear "99" PARENT_SCOPE)
	endif()
endfunction()

function(_Analysis_LangOpt)
	if(NOT _TESuit_LangType STREQUAL "")
		string(TOLOWER ${_TESuit_LangType} _TESuit_LangType)
	endif()
	if(NOT _TESuit_LangStdType STREQUAL "")
		string(TOLOWER ${_TESuit_LangStdType} _TESuit_LangStdType)
	endif()
	if(NOT _TESuit_LangStdYear STREQUAL "")
		string(TOLOWER ${_TESuit_LangStdYear} _TESuit_LangStdYear)
	endif()

	# If you put "std" in "Language Standard Option".
	if(_TESuit_LangStdType STREQUAL "std")
		set(_TESuit_LangStdTypeParm "c")
	else()
		if(_TESuit_LangStdType STREQUAL "")
			set(_TESuit_LangStdTypeParm "gnu")
		else()
			string(CONCAT _TESuit_LangStdTypeParm ${_TESuit_LangStdTypeParm} ${_TESuit_LangStdType})
		endif()
	endif()

	if(_TESuit_LangType STREQUAL "c++")
		string(CONCAT _TESuit_LangStdTypeParm ${_TESuit_LangStdTypeParm} "++")
	elseif(_TESuit_LangType STREQUAL "")
		set(_TESuit_LangType "c")
	endif()

	# Error check for "Years of Language Standard".
	if(_TESuit_LangType STREQUAL "c")
		if((NOT _TESuit_LangStdYear STREQUAL "89")
				AND (NOT _TESuit_LangStdYear STREQUAL "99")
				AND (NOT _TESuit_LangStdYear STREQUAL "9x")
				AND (NOT _TESuit_LangStdYear STREQUAL "11")
				AND (NOT _TESuit_LangStdYear STREQUAL "1x")
				AND (NOT _TESuit_LangStdYear STREQUAL "17")
				AND (NOT _TESuit_LangStdYear STREQUAL "18")
				AND (NOT _TESuit_LangStdYear STREQUAL "2x"))
			# Fix incorrectly set "Years of Language Standard" to the default settings(for C).
			set(_TESuit_LangStdYear "99")
		endif()
	elseif(_TESuit_LangType STREQUAL "c++")
		if((NOT _TESuit_LangStdYear STREQUAL "98")
				AND (NOT _TESuit_LangStdYear STREQUAL "03")
				AND (NOT _TESuit_LangStdYear STREQUAL "9x")
				AND (NOT _TESuit_LangStdYear STREQUAL "11")
				AND (NOT _TESuit_LangStdYear STREQUAL "0x")
				AND (NOT _TESuit_LangStdYear STREQUAL "14")
				AND (NOT _TESuit_LangStdYear STREQUAL "1y")
				AND (NOT _TESuit_LangStdYear STREQUAL "17")
				AND (NOT _TESuit_LangStdYear STREQUAL "1z")
				AND (NOT _TESuit_LangStdYear STREQUAL "2a"))
			# Fix incorrectly set "Years of Language Standard" to the default settings(for C++).
			set(_TESuit_LangStdYear "11")
		endif()
	endif()

	set(_TESuit_LangType ${_TESuit_LangType} PARENT_SCOPE)
	set(_TESuit_LangStdType ${_TESuit_LangStdType} PARENT_SCOPE)
	set(_TESuit_LangStdTypeParm ${_TESuit_LangStdTypeParm} PARENT_SCOPE)
	set(_TESuit_LangStdYear ${_TESuit_LangStdYear} PARENT_SCOPE)
endfunction()

function(_Set_LangStd)
#	if(_TESuit_LangType STREQUAL "c")
#		set(CMAKE_C_STANDARD ${_TESuit_LangStdYear} PARENT_SCOPE)
#		message(STATUS "CMAKE_C_STANDARD : ${CMAKE_C_STANDARD}, Year : ${_TESuit_LangStdYear}")
#	elseif(_TESuit_LangType STREQUAL "c++")
#		set(CMAKE_CXX_STANDARD ${_TESuit_LangStdYear} PARENT_SCOPE)
#		message(STATUS "CMAKE_CXX_STANDARD : ${CMAKE_CXX_STANDARD}, Year : ${_TESuit_LangStdYear}")
#	endif()
endfunction()

function(_Set_LangOpt __lang_std __lang_type __lang_year)
	string(TOLOWER ${__lang_type} _TStr_lang_type)
	string(TOLOWER ${__lang_std} _TStr_compiler_std)

	set(_TESuit_LangType ${_TStr_lang_type} PARENT_SCOPE)
	set(_TESuit_LangStdType ${_TStr_compiler_std} PARENT_SCOPE)
	set(_TESuit_LangStdYear ${__lang_year} PARENT_SCOPE)
endfunction()