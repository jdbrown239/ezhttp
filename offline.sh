#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#===============================================================================
#   SYSTEM REQUIRED:  Linux
#   DESCRIPTION:  automatic deploy your linux
#   AUTHOR: Zhu Maohai.
#   website: http://www.centos.bz/ezhttp/
#===============================================================================

cur_dir=`pwd`

#初始化
if [ -f $cur_dir/init ];then
	. $cur_dir/init
else
	echo "init file not found.shell script can't be executed."
	exit 1
fi
#载入常用函数
if [ -f $cur_dir/func ];then
	. $cur_dir/func
else
	echo "func file not found.shell script can't be executed."
	exit 1
fi

#显示各软件菜单
display_menu nginx
display_menu apache
display_menu mysql
display_menu php
echo "which software you'd install:"
for ((i=1;i<=${#other_soft_arr[@]};i++ )); do echo -e "$i) ${other_soft_arr[$i-1]}"; done
echo
other_prompt="please input a number: "
while true
do
	read -p "${other_prompt}" other_soft
	other_soft=(${other_soft})
	unset other_soft_install wrong
	for j in ${other_soft[@]}
	do
		if [ "${other_soft_arr[$j-1]}" == "" ];then
			other_soft_prompt="input errors,please input number a number: ";
			wrong=1
			break
		elif [ "${other_soft_arr[$j-1]}" == "do_not_install" ];then
			unset other_soft_install
			other_soft_install="do_not_install"
			break 2
		else
			other_soft_install="$other_soft_install ${other_soft_arr[$j-1]}"
			wrong=0
		fi
	done
	[ "$wrong" == 0 ] && break
done
echo -e "your other software selection ${other_soft_install}"

#开始下载软件
#下载nginx
if [ "$nginx" != "do_not_install" ];then

	download_file "${pcre_baidupan_link}" "${pcre_official_link}" "${pcre_filename}.tar.gz"
	download_file "${openssl_baidupan_link}" "${openssl_official_link}" "${openssl_filename}.tar.gz"
	download_file "${zlib_baidupan_link}" "${zlib_official_link}" "${zlib_filename}.tar.gz"

if [ "$nginx" == "${nginx_filename}" ];then
	download_file "${nginx_baidupan_link}" "${nginx_official_link}" "${nginx_filename}.tar.gz"

elif [ "$nginx" == "${tengine_filename}" ];then
	download_file "${tengine_baidupan_link}" "${tengine_official_link}" "${tengine_filename}.tar.gz"
	
elif [ "$nginx" == "${openresty_filename}" ];then
	download_file "${openresty_baidupan_link}" "${openresty_official_link}" "${openresty_filename}.tar.gz"	
fi

fi

#下载apache
if [ "$apache" != "do_not_install" ];then
	download_file "${zlib_baidupan_link}" "${zlib_official_link}" "${zlib_filename}.tar.gz"
	download_file "${openssl_baidupan_link}" "${openssl_official_link}" "${openssl_filename}.tar.gz"

	if [ "$apache" == "${apache2_2_filename}" ];then	
		download_file "${apache2_2_baidupan_link}" "${apache2_2_official_link}" "${apache2_2_filename}.tar.gz"

	elif [ "$apache" == "${apache2_4_filename}" ];then
		download_file "${pcre_baidupan_link}" "${pcre_official_link}" "${pcre_filename}.tar.gz"
		#下载apr和apr-util
		download_file "${apr_baidupan_link}" "${apr_official_link}" "${apr_filename}.tar.gz"
		download_file "${apr_util_baidupan_link}" "${apr_util_official_link}" "${apr_util_filename}.tar.gz"
		download_file "${apache2_4_baidupan_link}" "${apache2_4_official_link}" "${apache2_4_filename}.tar.gz"
	fi	

fi

#下载mysql
if [ "$mysql" != "do_not_install" ];then
	if [ "$mysql" == "${mysql5_1_filename}" ];then
		download_file "${ncurses_baidupan_link2}" "${ncurses_official_link2}" "${ncurses_filename2}.tar.gz"
		download_file "${mysql5_1_baidupan_link}" "${mysql5_1_official_link}" "${mysql5_1_filename}.tar.gz"

	elif [ "$mysql" == "${mysql5_5_filename}" ] || [ "$mysql" == "libmysqlclient18" ];then
		download_file "${ncurses_baidupan_link}" "${ncurses_official_link}" "${ncurses_filename}.tar.gz"
		download_file "${cmake_baidupan_link}" "${cmake_official_link}" "${cmake_filename}.tar.gz"
		download_file "${m4_baidupan_link}" "${m4_official_link}" "${m4_filename}.tar.gz"
		download_file "${bison_baidupan_link}" "${bison_official_link}" "${bison_filename}.tar.gz"
		download_file "${mysql5_5_baidupan_link}" "${mysql5_5_official_link}" "${mysql5_5_filename}.tar.gz"
				
	elif [ "$mysql" == "${mysql5_6_filename}" ];then
		download_file "${ncurses_baidupan_link}" "${ncurses_official_link}" "${ncurses_filename}.tar.gz"
		download_file "${cmake_baidupan_link}" "${cmake_official_link}" "${cmake_filename}.tar.gz"
		download_file "${m4_baidupan_link}" "${m4_official_link}" "${m4_filename}.tar.gz"
		download_file "${bison_baidupan_link}" "${bison_official_link}" "${bison_filename}.tar.gz"
		download_file "${mysql5_6_baidupan_link}" "${mysql5_6_official_link}" "${mysql5_6_filename}.tar.gz"
		
	fi	
fi

#下载php
if [ "$php" != "do_not_install" ];then
	download_file "${m4_baidupan_link}" "${m4_official_link}" "${m4_filename}.tar.gz"
	download_file "${autoconf_baidupan_link}" "${autoconf_official_link}" "${autoconf_filename}.tar.gz"
	download_file "${libxml2_baidupan_link}" "${libxml2_official_link}" "${libxml2_filename}.tar.gz"
	download_file "${openssl_baidupan_link}" "${openssl_official_link}" "${openssl_filename}.tar.gz"
	download_file "${zlib_baidupan_link}" "${zlib_official_link}" "${zlib_filename}.tar.gz"
	download_file "${libcurl_baidupan_link}" "${libcurl_official_link}" "${libcurl_filename}.tar.gz"
	download_file "${pcre_baidupan_link}" "${pcre_official_link}" "${pcre_filename}.tar.gz"
	download_file "${libtool_baidupan_link}" "${libtool_official_link}" "${libtool_filename}.tar.gz"
	download_file "${libjpeg_baidupan_link}" "${libjpeg_official_link}" "${libjpeg_filename}.tar.gz"
	download_file "${libpng_baidupan_link}" "${libpng_official_link}" "${libpng_filename}.tar.gz"
	download_file "${mhash_baidupan_link}" "${mhash_official_link}" "${mhash_filename}.tar.gz"
	download_file "${libmcrypt_baidupan_link}" "${libmcrypt_official_link}" "${libmcrypt_filename}.tar.gz"

	if [ "$php" == "${php5_2_filename}" ];then
		download_file "${patch_baidupan_link}" "${patch_official_link}" "${patch_filename}.tar.gz"
		download_file "${php5_2_baidupan_link}" "${php5_2_official_link}" "${php5_2_filename}.tar.gz"
				
	elif [ "$php" == "${php5_3_filename}" ];then
		download_file "${php5_3_baidupan_link}" "${php5_3_official_link}" "${php5_3_filename}.tar.gz"
				
	elif [ "$php" == "${php5_4_filename}" ];then
		download_file "${php5_4_baidupan_link}" "${php5_4_official_link}" "${php5_4_filename}.tar.gz"
		
	fi

	#下载php模块
	if if_in_array "${ZendOptimizer_filename}" "$php_modules_install";then 
		download_file "${ZendOptimizer64_baidupan_link}" "${ZendOptimizer64_official_link}" "${ZendOptimizer64_filename}.tar.gz"
		download_file "${ZendOptimizer32_baidupan_link}" "${ZendOptimizer32_official_link}" "${ZendOptimizer32_filename}.tar.gz"
	fi
		
	if if_in_array "${eaccelerator_filename}" "$php_modules_install";then
		download_file "${m4_baidupan_link}" "${m4_official_link}" "${m4_filename}.tar.gz"
		download_file "${autoconf_baidupan_link}" "${autoconf_official_link}" "${autoconf_filename}.tar.gz"
		download_file "${eaccelerator_baidupan_link}" "${eaccelerator_official_link}" "${eaccelerator_filename}.tar.bz2"
	fi
		
	if if_in_array "${php_memcache_filename}" "$php_modules_install";then
		download_file "${zlib_baidupan_link}" "${zlib_official_link}" "${zlib_filename}.tar.gz"
		download_file "${m4_baidupan_link}" "${m4_official_link}" "${m4_filename}.tar.gz"
		download_file "${autoconf_baidupan_link}" "${autoconf_official_link}" "${autoconf_filename}.tar.gz"
		download_file "${php_memcache_baidupan_link}" "${php_memcache_official_link}" "${php_memcache_filename}.tgz"
	fi

	if if_in_array "${php_imagemagick_filename}" "$php_modules_install";then
		download_file "${ImageMagick_baidupan_link}" "${ImageMagick_official_link}" "${ImageMagick_filename}.tar.gz"
		download_file "${pkgconfig_baidupan_link}" "${pkgconfig_official_link}" "${pkgconfig_filename}.tar.gz"
		download_file "${m4_baidupan_link}" "${m4_official_link}" "${m4_filename}.tar.gz"
		download_file "${autoconf_baidupan_link}" "${autoconf_official_link}" "${autoconf_filename}.tar.gz"
		download_file "${php_imagemagick_baidupan_link}" "${php_imagemagick_official_link}" "${php_imagemagick_filename}.tgz"		

	fi	
		
	if if_in_array "${ZendGuardLoader_filename}" "$php_modules_install";then
		download_file "${ZendGuardLoader53_64_baidupan_link}" "${ZendGuardLoader53_64_official_link}" "${ZendGuardLoader53_64_filename}.tar.gz"
		download_file "${ZendGuardLoader54_64_baidupan_link}" "${ZendGuardLoader54_64_official_link}" "${ZendGuardLoader54_64_filename}.tar.gz"
		download_file "${ZendGuardLoader53_32_baidupan_link}" "${ZendGuardLoader53_32_official_link}" "${ZendGuardLoader53_32_filename}.tar.gz"
		download_file "${ZendGuardLoader54_32_baidupan_link}" "${ZendGuardLoader54_32_official_link}" "${ZendGuardLoader54_32_filename}.tar.gz"

	fi
		
	if if_in_array "${ionCube_filename}" "$php_modules_install";then
		download_file "${ionCube64_baidupan_link}" "${ionCube64_official_link}" "${ionCube64_filename}.tar.gz"
		download_file "${ionCube32_baidupan_link}" "${ionCube32_official_link}" "${ionCube32_filename}.tar.gz"
	fi	

fi

#下载soft
if if_in_array "${memcached_filename}" "$other_soft_install";then
	download_file "${libevent_baidupan_link}" "${libevent_official_link}" "${libevent_filename}.tar.gz"
	download_file "${memcached_baidupan_link}" "${memcached_official_link}" "${memcached_filename}.tar.gz"
fi

if if_in_array "${PureFTPd_filename}" "$other_soft_install";then
	download_file "${PureFTPd_baidupan_link}" "${PureFTPd_official_link}" "${PureFTPd_filename}.tar.gz"
fi

if if_in_array "${phpMyAdmin_filename}" "$other_soft_install";then
	download_file "${phpMyAdmin_baidupan_link}" "${phpMyAdmin_official_link}" "${phpMyAdmin_filename}.tar.gz"
fi	

#开始打包
cd $cur_dir
if [[ -s soft.tar.gz ]];then
	echo "file soft.tar.gz had already exsit,please rename or remove."
	exit 1 
else	
	tar czvf soft.tar.gz soft && echo "offline package has sucessfully made."
fi	 
