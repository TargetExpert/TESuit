#=========================================================================
#
#          File: TEInclude.cmake
#
#   Description: Include scripts for Prebuild and Postbuild.
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

include(${CMAKE_CURRENT_LIST_DIR}/TEVars.cmake)

include(${_TESuit_Dir_Name}/${_TESuit_init_Dir_Name}/TEInit.cmake)
include(${_TESuit_Dir_Name}/${_TESuit_prebuild_Dir_Name}/TEPrebuild.cmake)
include(${_TESuit_Dir_Name}/${_TESuit_postbuild_Dir_Name}/TEPostbuild.cmake)