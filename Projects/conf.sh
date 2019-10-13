#!/bin/sh
#/***************************************************************************
# File : conf.sh
#
# Description : Script to help configuration for the "CMakeLists.txt" file.
#
# Author : Jinseong Jeon (aimer120@nate.com)
#
# Created : 2019/09/27
#
# Copyright (c) 2018, TargetExpert Project is Gabriel Kim(Doohoon Kim),
# All rights reserved.
#
# ** The "TargetExpert" is distributed under the "3-clause BSD" license.
#    See details COPYING.
#
#***************************************************************************/


SCRIPT_VER=0.0.1
SCRIPT=$0
CUR_PATH=`pwd`
TG_PORT=/dev
SOPTS=p:c:f:t:P:I:ih
LOPTS=project:,core:,frequency:,type:,port:,import:,cmake-info,help
CMAKE_LATEST_LINK=https://github.com/Kitware/CMake/releases/download/v3.15.3/cmake-3.15.3.tar.gz
CLI_BUILD=1	# set 0 -> other tool build / set != 0 -> cli build
DEBUG=0		# set 0 -> release mode / set != 0 -> debug mode
norm="\033[0m"
err="\033[0;31m"
warn="\033[1;33m"
comp="\033[0;32m"

usage() {
	cat <<- END
	Usage: sh ${SCRIPT} OPTION...
	Create a "CMakeLists.txt" file with the values you inputted.
	(Default path is inside your project directory you specified.)

	Mandatory arguments to long options are mandatory for short options too.
	  -p, --project=STRING		specify the project name you have created
	  -c, --core=STRING		specify the MCU type of the target machine
	  -f, --frequency=NUM		specify the MCU frequency of the target machine
	  -t, --type=STRING		specify the device type of the target machine
	  -P, --port=STRING		specify the port connected to the target machine
					(default is "/dev")
	  -I, --import			specify an directory name or path for an external source
					(default is project directory)
	  -i, --cmake-info		print a simple information about "cmake" build-tool
	  -h, --help			display this help and exit

	Examples:
	  sh ${SCRIPT} -p TESuit -c atmega328p -f 16000000 -t arduino -P xxx -I test
	  If you input the above command, the contents of the created file are as follows.
	---------------------------------------------------------- Start 
		cmake_minimum_required(VERSION 3.14)
	        
		include(TESuit/TEInclude.cmake)

		Set_Project(TESuit)
		Set_Target(atmega328p)
		Set_TargetFreq(16000000)
		Set_JointInterface(arduino)
		Set_JointPort(/dev/xxx)
		Set_ExtSourcePath(test)

		Init_TE()
		Prebuild_TE()

		project(\${Project_Name} \${Language})
		add_executable(\${Project_Name} main.c \${Src_Files})

		Postbuild_TE()
	------------------------------------------------------------ End 
	END
}

#TODO:
#	install_cmake remove -> cmake dockernization
install_cmake() {
	if [ ${CLI_BUILD} -eq 0 ]; then
		return 0
	fi

	local ack=
	local cmd_cmake=`command -v cmake`
	if [ ${cmd_cmake} ]; then
		local chk_cm_ver=`cmake --version | grep version | tr -d "[:lower:][:upper:][:blank:]"`
		local major=${chk_cm_ver%%.*}
		local minor=`echo ${chk_cm_ver} | cut -d '.' -f 2`

		[ ${major} -gt 3 ] && return 0
		[ ${major} -eq 3 -a ${minor} -ge 14 ] && return 0

		cat <<- END
		------------------------------------------------
		Your cmake version is ${chk_cm_ver},
		but the build requires version 3.14 or later.

		Do you want to remove the old "cmake" and
		install it up to date?
		------------------------------------------------
		END
		echo -n "y/n> " && read ack
		case ${ack} in
		[yY]|[yY][eE][sS]) echo "" ;;
		[nN]|[nN][oO]|*) return 0 ;;
		esac
	fi

	local host_os= chk_cmd= rm_cmd=
	if [ -r /etc/os-release ]; then
                host_os=`. /etc/os-release && echo $ID`
        elif [ `command -v lsb_release` ]; then
		host_os=`lsb_release -i | cut -d ":" -f 2`
        else
		host_os=`cat /etc/issue \
			| sed "s/.*\(Ubuntu\).*\|.*\(Debian\).*\|.*\(CentOS\).*\|.*\(Fedora\).*/\1\2\3\4/"`
        fi
	host_os=`echo ${host_os} | tr [:upper:] [:lower:] | tr -d [:blank:]`

	case ${host_os} in
	ubuntu|debian)
		chk_cmd="dpkg -l"
		rm_cmd="sudo apt-get remove" ;;
	centos|fedora)
		chk_cmd="rpm -qa"
		rm_cmd="sudo yum remove" ;;
	*)
		echo >&2 "${warn}Cmake install fail: Not supported your OS${norm}"
		if [ ${DEBUG} -ne 0 ]; then
			cat /etc/issue
		fi
		return 0 ;;
	esac

	local chk_pkg=`${chk_cmd} | grep "cmake" | grep -v "[[:graph:]]cmake\|cmake[[:graph:]]" | wc -l`
	if [ ${chk_pkg} -ne 0 ]; then
		${rm_cmd} cmake
	elif [ ${cmd_cmake} ]; then
		echo >&2 "${err}The installation path for \"cmake\" could not be found,"
		echo >&2 "Please remove the old version installed and try.${norm}"
		return 0
	fi

	if [ ! ${ack} ]; then
		cat <<- END
		------------------------------------------------
		  Cmake is not installed on your system,
		  Do you want to proceed with the installation.
		------------------------------------------------
		END
		echo -n "y/n> " && read ack
	fi
	case ${ack} in
	[yY]|[yY][eE][sS])
		cd /usr/local/src
		sudo wget ${CMAKE_LATEST_LINK}
		local cmake_tgz=`echo ${CMAKE_LATEST_LINK} | rev | cut -d '/' -f 1 | rev`
		sudo tar xzf ${cmake_tgz} && sudo rm ${cmake_tgz}
		local cmake_dir=${cmake_tgz%%.tar*}
		cd ${cmake_dir}
		sudo ./bootstrap && sudo make -j2 && sudo make install
		cd ${CUR_PATH} ;;
		#TODO: PATH setting
	[nN]|[nN][oO]|*) return 0 ;;
	esac
}

cmake_info() {
	cm_ver=`cmake --version 2>&1 | grep version | tr -d "[:lower:][:upper:][:blank:]"`
	cm_env_lists=`cmake --system-information 2>&1 \
		| grep "CMAKE_ROOT\|_CMAKE_TOOLCHAIN_LOCATION\|CMAKE_CURRENT_LIST_FILE" \
	       	| tr -d '"' | awk '{printf "%s=%s ", $1, $2}'`

	for item in ${cm_env_lists}
	do
		case ${item} in
		CMAKE_ROOT*) cm_root=${item#*=} ;;
		_CMAKE_TOOLCHAIN_LOCATION*) cm_tool=${item#*=} ;;
		CMAKE_CURRENT_LIST_FILE*) cm_list=${item#*=} ;;
		esac
	done

	cat <<- END
	------------------------------------------------
	               CMAKE INFORMATION
	------------------------------------------------
	- Version: ${cm_ver}
	- Install Path: ${cm_root}
	- Toolchain Path: ${cm_tool}
	- List file Path: ${cm_list}
	END
}

parse_opts() {
	local pf=0 cf=0 ff=0 tf=0

	parse_lists=`getopt -o ${SOPTS} -l ${LOPTS} --name ${SCRIPT} -- "$@"`		#TODO: Error message duplicate
	if [ $? -ne 0 -o $# -eq 0 ]; then						#	ex. "-ddd" option prints error message 3 times.
		echo >&2 "Try '${SCRIPT} --help' for more information."
		exit 255
	fi
	eval set -- ${parse_lists}
	if [ ${DEBUG} -ne 0 ]; then
		echo ${parse_lists}
	fi

	while true; do
		case $1 in
		-p|--project)
			pf=1
			case $2 in
			=*|-*|''|' ') echo >&2 "${SCRIPT}: $2: invalid project name argument" ; exit 255 ;;
			esac
			PROJ_NAME=$2 && shift 2
			if [ ! -d ${CUR_PATH}/${PROJ_NAME} ]; then
				if [ ${CLI_BUILD} -ne 0 ]; then
					mkdir ${PROJ_NAME}
					continue
				fi
				echo >&2 "The project does not exist, Please create a project first."
				exit 255
			fi ;;
		-c|--core)
			cf=1
			case $2 in
			=*|-*|''|' ') echo >&2 "${SCRIPT}: $2: invalid core name argument" ; exit 255 ;;
			esac
			TG_MCU=$2 && shift 2 ;;
		-f|--frequency)
			ff=1
			local chk_num=`echo $2 | tr -d [:digit:]`
			if [ ! -z $chk_num ]; then
				echo >&2 "${SCRIPT}: $2: invalid frequency value argument"
				exit 255
			fi
			case $2 in
			''|' ') echo >&2 "${SCRIPT}: $2: invalid frequency value argument" ; exit 255 ;;
			esac
			TG_FREQ=$2 && shift 2 ;;
		-t|--type)
			tf=1
			case $2 in
			=*|-*|''|' ') echo >&2 "${SCRIPT}: $2: invalid type name argument" ; exit 255 ;;
			esac
			TG_TYPE=$2 && shift 2 ;;
		-P|--port)
			case $2 in
			=*|-*|''|' ') echo >&2 "${SCRIPT}: $2: invalid port name argument" ; exit 255 ;;
			esac
			TG_PORT=/dev/$2 && shift 2 ;;
		-I|--import)
			EXT_SRC=$2
			case $2 in
			=*|-*|''|' ') echo >&2 "${SCRIPT}: $2: invalid external path argument" ; exit 255 ;;
			*/) EXT_SRC=${EXT_SRC%/} ;;
			esac
			shift 2 ;;
		-i|--cmake-info) install_cmake && cmake_info ; exit 0 ;;
		-h|--help) usage ; exit 0 ;;
		--) shift ; break ;;
		*) break ;;
		esac
	done

	# Check the essential options.
	if [ $((${pf}+${cf}+${ff}+${tf})) -ne 4 ]; then
		echo >&2 "You must specify the '--project', '--core', '--frequency', '--type' options"
		exit 255
	fi
}

show_info() {
	cat <<- END
	------------------------------------------------
	    Your target configurations are as follow  
	------------------------------------------------
	* Project name: ${PROJ_NAME}
	* MCU: ${TG_MCU}
	* Frequency: ${TG_FREQ}HZ
	* Type: ${TG_TYPE}
	* Connected port: ${TG_PORT}
	* External source path: ${EXT_SRC}

	END
}

#TODO: External source path -> list type
create_cmakelist() {
	if [ ${CLI_BUILD} -eq 0 ]; then
		CM_VER=3.14
	else
		CM_VER=`cmake --version 2>&1 | grep version | tr -d "[:lower:][:upper:][:blank:]"`
	fi

	cat <<- EOF > ${PROJ_NAME}/CMakeLists.txt
	cmake_minimum_required(VERSION ${CM_VER})
	
	include(TESuit/TEInclude.cmake)

	Set_Project(${PROJ_NAME})
	Set_Target(${TG_MCU})
	Set_TargetFreq(${TG_FREQ})
	Set_JointInterface(${TG_TYPE})
	Set_JointPort(${TG_PORT})
	Set_ExtSourcePath(${EXT_SRC})

	Init_TE()
	Prebuild_TE()

	project(\${Project_Name} \${Language})
	add_executable(\${Project_Name} main.c \${Src_Files})

	Postbuild_TE()
	EOF

	echo "Finish creating "CMakeLists.txt" file."
}

link_src() {
	local internal_src=TargetExpert
	local build_utils=TESuit
	local external_src=${EXT_SRC}

	[ ! -d ${CUR_PATH}/../${internal_src} ] && \
		echo >&2 "${err}${internal_src}: link fail, Run \"init.sh\" first and try.${norm}" && exit 255
	[ ! -d ${PROJ_NAME}/${build_utils} ] && ln -s ${CUR_PATH}/../${build_utils} ${PROJ_NAME}/.
	[ ! -d ${PROJ_NAME}/${internal_src} ] && ln -s ${CUR_PATH}/../${internal_src} ${PROJ_NAME}/.

	if [ ${external_src} ]; then
		EXT_SRC=${EXT_SRC##*/}
		if [ -d ${PROJ_NAME}/${EXT_SRC} ]; then
			return 0
		elif [ -d ${external_src} ]; then
			[ ${external_src%%/*} ] && external_src=${CUR_PATH}/${external_src}
			ln -s ${external_src} ${PROJ_NAME}/.
		else
			echo >&2 "${warn}${EXT_SRC}: Does not exist the specified source directory in ${PROJ_NAME} directory.${norm}"
		fi
	else
		EXT_SRC="''"
	fi
}


# main process
parse_opts "$@"

show_info

install_cmake

link_src

create_cmakelist

echo "${comp}All cofiguration complete.${norm}"
