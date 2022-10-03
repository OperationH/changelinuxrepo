#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

Font_Black="\033[30m";
Font_Red="\033[31m";
Font_Green="\033[32m";
Font_Yellow="\033[33m";
Font_Blue="\033[34m";
Font_Purple="\033[35m";
Font_SkyBlue="\033[36m";
Font_White="\033[37m";
Font_Suffix="\033[0m";
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[INFO]${Font_color_suffix}"
Error="${Red_font_prefix}[ERROR]${Font_color_suffix}"
Tip="${Green_font_prefix}[TIP]${Font_color_suffix}"

check_sys(){
if [[ -f /etc/redhat-release ]]; then
	release="centos"
elif cat /etc/issue | grep -q -E -i "debian"; then
	release="debian"
elif cat /etc/issue | grep -q -E -i "ubuntu"; then
	release="ubuntu"
elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
	release="centos"
elif cat /proc/version | grep -q -E -i "debian"; then
	release="debian"
elif cat /proc/version | grep -q -E -i "ubuntu"; then
	release="ubuntu"
elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
	release="centos"
	fi
}


check_version(){
	if [[ -s /etc/redhat-release ]]; then
		version=`grep -oE  "[0-9.]+" /etc/redhat-release | cut -d . -f 1`
	else
		version=`grep -oE  "[0-9.]+" /etc/issue | cut -d . -f 1`
	fi
	bit=`uname -m`
	if [[ ${bit} = "x86_64" ]]; then
		bit="x64"
	else
		bit="x32"
	fi
}

backup(){
	clear 
	if [[ "${release}" == "centos" ]] && [[ ! -f "/etc/yum.repos.d/CentOS-Base.repo.backup" ]]; then 
	echo -e "${Green_font_prefix}正在備份默認源${Font_color_suffix}"
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
	echo -e "${Green_font_prefix}已備份至/etc/yum.repos.d/CentOS-Base.repo.backup${Font_color_suffix}"
else
	echo -e "${Green_font_prefix}默認源備份已存在，將跳過備份${Font_color_suffix}"
	fi
}

aliyun(){
	if [[ "${release}" == "centos" ]] && [[ "${version}" == "7" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
	yum makecache
	yum -y update
	echo -e "${Green_font_prefix}已更替為阿里雲源${Font_color_suffix}"
elif [[ "${release}" == "centos" ]] && [[ "${version}" == "6" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
	yum makecache
	yum -y update
	echo -e "${Green_font_prefix}已更替為阿里雲源${Font_color_suffix}"
elif [[ "${release}" == "centos" ]] && [[ "${version}" == "5" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	wget -O wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-5.repo
	yum makecache
	yum -y update
	echo -e "${Green_font_prefix}已更替為阿里雲源${Font_color_suffix}"	
elif [[ "${release}" == "debian" ]] && [[ "${version}" == "11" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	echo "deb http://mirrors.aliyun.com/debian/ bullseye main non-free contrib" >/etc/apt/sources.list
	apt update -y
	echo -e "${Green_font_prefix}已更替為阿里雲源${Font_color_suffix}"	
elif [[ "${release}" == "debian" ]] && [[ "${version}" == "10" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	echo "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib" >/etc/apt/sources.list
	apt update -y
	echo -e "${Green_font_prefix}已更替為阿里雲源${Font_color_suffix}"	
else
	echo -e "${Green_font_prefix}系統檢測失敗或腳本不支持您的系統${Font_color_suffix}"
	exit 1
fi
}

huawei(){
	if [[ "${release}" == "centos" ]] && [[ "${version}" == "7" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	wget -O /etc/yum.repos.d/CentOS-Base.repo https://repo.huaweicloud.com/repository/conf/CentOS-7-reg.repo
	yum makecache
	yum -y update
	echo -e "${Green_font_prefix}已更替為華為雲源${Font_color_suffix}"
elif [[ "${release}" == "centos" ]] && [[ "${version}" == "6" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	wget -O /etc/yum.repos.d/CentOS-Base.repo https://repo.huaweicloud.com/repository/conf/CentOS-6-reg.repo
	yum makecache
	yum -y update
	echo -e "${Green_font_prefix}已更替為華為雲源${Font_color_suffix}"
elif [[ "${release}" == "centos" ]] && [[ "${version}" == "5" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	wget -O wget -O /etc/yum.repos.d/CentOS-Base.repo https://repo.huaweicloud.com/repository/conf/CentOS-5-reg.repo
	yum makecache
	yum -y update
	echo -e "${Green_font_prefix}已更替為華為雲源${Font_color_suffix}"	
elif [[ "${release}" == "debian" ]] && [[ "${version}" == "11" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	echo "deb https://mirrors.huaweicloud.com/debian/ bullseye main contrib non-free" >/etc/apt/sources.list
	apt update -y
	echo -e "${Green_font_prefix}已更替為華為雲源${Font_color_suffix}"	
elif [[ "${release}" == "debian" ]] && [[ "${version}" == "10" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	echo "deb https://mirrors.huaweicloud.com/debian/ buster main contrib non-free" >/etc/apt/sources.list
	apt update -y
	echo -e "${Green_font_prefix}已更替為華為雲源${Font_color_suffix}"	
else
	echo -e "${Green_font_prefix}系統檢測失敗或腳本不支持您的系統${Font_color_suffix}"
	exit 1
fi
}


163(){
	if [[ "${release}" == "centos" ]] && [[ "${version}" == "7" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
	yum makecache
	yum -y update
	echo -e "${Green_font_prefix}已更替為163源${Font_color_suffix}"
elif [[ "${release}" == "centos" ]] && [[ "${version}" == "6" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS6-Base-163.repo
	yum makecache
	yum -y update
	echo -e "${Green_font_prefix}已更替為163源${Font_color_suffix}"
elif [[ "${release}" == "centos" ]] && [[ "${version}" == "5" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	wget -O wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS5-Base-163.repo
	yum makecache
	yum -y update
	echo -e "${Green_font_prefix}已更替為163源${Font_color_suffix}"	
elif [[ "${release}" == "debian" ]] && [[ "${version}" == "11" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	echo "deb http://mirrors.163.com/debian/ bullseye main non-free contrib" >/etc/apt/sources.list
	apt update -y
	echo -e "${Green_font_prefix}已更替為163源${Font_color_suffix}"	
elif [[ "${release}" == "debian" ]] && [[ "${version}" == "10" ]];then
	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	echo "deb http://mirrors.163.com/debian/ buster main non-free contrib" >/etc/apt/sources.list
	apt update -y
	echo -e "${Green_font_prefix}已更替為163源${Font_color_suffix}"	
else
	echo -e "${Green_font_prefix}系統檢測失敗或腳本不支持您的系統${Font_color_suffix}"
	exit 1
fi
}

recovery(){
	if [[ "${release}" == "centos" ]] && [[ ! -f "/etc/yum.repos.d/CentOS-Base.repo.backup" ]];then
	mv /etc/yum.repos.d/CentOS-Base.repo.backup /etc/yum.repos.d/CentOS-Base.repo 
	yum makecache
	yum -y update
	echo -e "${Green_font_prefix}已還原為默認源${Font_color_suffix}"
elif [[ "${release}" == "debian" ]]&& [[ "${version}" == "10" ]];then
	echo "deb http://deb.debian.org/debian/ buster main non-free contrib" >/etc/apt/sources.list
	apt update -y
	echo -e "${Green_font_prefix}已還原為默認源${Font_color_suffix}"
elif [[ "${release}" == "debian" ]]&& [[ "${version}" == "11" ]];then
	echo "deb http://deb.debian.org/debian/ bullseye main non-free contrib" >/etc/apt/sources.list
	apt update -y
	echo -e "${Green_font_prefix}已還原為默認源${Font_color_suffix}"
else
	echo -e "${Green_font_prefix}備份不存在或系統檢測失敗${Font_color_suffix}"
	exit 1
fi
}

menu(){
clear
check_sys
check_version
echo && echo -e " ${Red_font_prefix}Linux系統更替Repo${Font_color_suffix}
   
 ${Green_font_prefix}1.${Font_color_suffix}  更替為阿里雲源
 ${Green_font_prefix}2.${Font_color_suffix}  更替為華為雲源
 ${Green_font_prefix}3.${Font_color_suffix}  更替為163源
 ———————————————————————————————————————————————
 ${Green_font_prefix}4.${Font_color_suffix}  還原為默認源
 ———————————————————————————————————————————————
 ${Green_font_prefix}5.${Font_color_suffix}  退出腳本
 ———————————————————————————————————————————————" &&

	echo -e " 系統為: ${Font_color_suffix}$release${Font_color_suffix}"
	echo -e " 版本為: ${Font_color_suffix}$version${Font_color_suffix}"
	
read -e -p " PLEASE ENTER NUMBER:" num
case "$num" in
	1)
	backup
	aliyun
	;;
	2)
	backup
	huawei
	;;
	3)
	backup
	163
	;;
	4)
	recovery
	;;
	5)
	exit 1
	;;
	*)
	echo -e "${Green_font_prefix}請輸入正確數字${Font_color_suffix}"
	menu
	;;
esac
}
