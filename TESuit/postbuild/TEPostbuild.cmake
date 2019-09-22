#=========================================================================
#
#          File: TEPostbuild.cmake
#
#   Description: Postbuild function for easy settings of postbuild
#                instructions.
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

function(TE_Postbuild)

	include(${CMAKE_CURRENT_LIST_DIR}/TESuit/arch/avr8.postbuild.cmake)

endfunction()