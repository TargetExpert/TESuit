#=========================================================================
#
#          File: TEAutoTarget.cmake
#
#   Description: Help distinguish work for "Target Machines"
#                automatically.
#
#        Author: Doohoon Kim (Gabriel Kim, invi.dh.kim@gmail.com)
#
#       Created: 2019/09/23
#
#  Copyright (c) 2019, TargetExpert Project is Gabriel Kim(Doohoon Kim),
#  All rights reserved.
#
#  ** The "TargetExpert" is distributed under the "3-clause BSD" license.
#     See details COPYING.
#
#=========================================================================

function(_Find_Target which_directory extension_list)
	set(_TArchStr "")
	set(_TDeviceNamePrefix "")
	file(GLOB this_directory_all_files "${which_directory}/*")

	if(this_directory_all_files)
		foreach(one_of_exist_all_list ${this_directory_all_files})
			if(NOT IS_DIRECTORY ${one_of_exist_all_list})
				# Found File.
				set(_TDicFile ${one_of_exist_all_list})
				break()
			endif()
		endforeach()

		file(READ ${_TDicFile} _TDiclist)
		string(ASCII 27 Esc)
		string(REGEX REPLACE "\n" ";" _TDiclist "${_TDiclist}")

		foreach(_TDicElem ${_TDiclist})
			string(FIND ${_TDicElem} "_" _TPos)

			if(NOT _TPos EQUAL -1)
				string(REGEX REPLACE "_" "" _TArchStr "${_TDicElem}")
				continue()
			endif()

			string(FIND ${_TDicElem} "=" _TPos)

			if(NOT _TPos EQUAL -1)
				string(REGEX REPLACE "=" "" _TDeviceNamePrefix "${_TDicElem}")

				if(_TESuit_Target MATCHES ${_TDeviceNamePrefix})
					break()
				endif()
			endif()
		endforeach()
	endif()

	set(_TESuit_Target_Arch_Name ${_TArchStr} PARENT_SCOPE)
endfunction()