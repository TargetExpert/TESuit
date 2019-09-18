#=========================================================================
#
#          File: TEAutoInc.cmake
#
#   Description: Recursive function for easy inclusion of files
#                and directories.
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

function(TE_AutoInc which_directory extension_list)

	file(GLOB this_directory_all_files "${which_directory}/*")

	#if(${which_directory} MATCHES ${CMAKE_SOURCE_DIR})
	#	string(REGEX REPLACE "${CMAKE_SOURCE_DIR}" "." which_directory "${which_directory}")
	#endif()

	if(this_directory_all_files)
		# check the block list.
		# remove "BlockList" File from list
		file(READ TESuit/BlockList block_list)
		string(ASCII 27 Esc)
		string(REGEX REPLACE "\n" ";" block_list "${block_list}")

		foreach(block_files ${block_list})
			set(block_files_src ${which_directory}/${block_files})
			file(GLOB block_file_src ${block_files_src})
			if(block_file_src)
				list(REMOVE_ITEM this_directory_all_files ${block_file_src})
			endif()
		endforeach()

		# separate for file list and directory list
		set(file_list "")

		foreach(one_of_exist_all_list ${this_directory_all_files})
			if(NOT IS_DIRECTORY ${one_of_exist_all_list})
				# It's a file
				# remaining all directory list and remove file list.
				list(REMOVE_ITEM this_directory_all_files ${one_of_exist_all_list})
			endif()
		endforeach()

		# check the file extension for all sources.
		foreach(file_extension ${extension_list})
			set(file_extension_src ${which_directory}/*${file_extension})
			file(GLOB this_directory_src ${file_extension_src})

			if(this_directory_src)
				if(this_directory_src MATCHES ${CMAKE_SOURCE_DIR})
					string(REGEX REPLACE "${CMAKE_SOURCE_DIR}/" "" this_directory_src "${this_directory_src}")
				endif()
				set(file_list ${file_list} ${this_directory_src})
			endif()
		endforeach()

		# entering directory when 'foreach'.
		foreach(one_of_exist_all_list ${this_directory_all_files})
			if(IS_DIRECTORY ${one_of_exist_all_list})
				# only remain directories.
				TE_AutoInc(${one_of_exist_all_list} ".c;.cpp;.h;.hpp;.cc")
			endif()
		endforeach()

		set(TE_src_files ${TE_src_files} ${file_list} PARENT_SCOPE)

		if(${which_directory} MATCHES ${CMAKE_SOURCE_DIR})
			string(REGEX REPLACE "${CMAKE_SOURCE_DIR}/" "" which_directory "${which_directory}")
		endif()

		set(TE_src_directories ${TE_src_directories} ${which_directory} PARENT_SCOPE)

	endif()

endfunction()