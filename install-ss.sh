#!/bin/sh
echo "开始安装番茄利器插件"
opkg update
opkg install pdnsd
/etc/init.d/pdnsd start
/etc/init.d/pdnsd enable
cd /tmp
rm -rf ThirdFlameTemp
mkdir ThirdFlameTemp
cd ThirdFlameTemp
if [ -f /etc/config/ss-redir ]; then
uci_get_configfn_version=`uci get ss-redir.ssgoabroad.config_file_version 2>/dev/null`
if [ "$?" == "0" ] && [ "$uci_get_configfn_version" == "2.6.3" ]; then
cp -a /etc/config/ss-redir /etc/config/ss-redir.2.6.3.bak
echo -e "备份配置文件--------------------------------------[\e[32m完成\e[37m]"
else
echo -e "备份配置文件--------------------------------------[\e[31m失败\e[37m]"
echo "失败原因：配置文件与当前安装版本不兼容"
fi
fi
echo -n "备份系统文件----------------------"
if [ -f /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm.bak ]; then
echo -e "[\e[31m失败、备份文件已存在\e[37m]"
else
cp -a /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm.bak
echo -e "----------------[\e[32m完成\e[37m]"
fi
echo "下载所需要的文件---------------------------------"
wget http://sspanel.tabboa.com/ss-redir.tar.gz
if [ -f ss-redir.tar.gz ]; then
echo -e "--------------------------------------------------[\e[32m完成\e[37m]"
echo "开始安装，正在安装的文件:"
tar -C / -xvzfss-redir.tar.gz 
if [ "$?" == "0" ]; then
echo -e "修改系统文件--------------------------------------[\e[32m完成\e[37m]"
echo -n "修正配置界面--------------------------------------"
sed -i 's/height:590/height:620/g' /usr/lib/lua/luci/view/admin_web/home.htm;
sed -i 's/.setup_box{ margin-left: 169px; height: 460px;/.setup_box{ margin-left: 169px; height: 496px;/g' /www/turbo-static/turbo/web/css/style.css;	
echo -e "[\e[32m完成\e[37m]"
echo -n "清除LUCI缓存--------------------------------------"
rm -rf /tmp/luci-indexcache
echo -e "[\e[32m完成\e[37m]"
chmod +x /etc/init.d/*
chmod +x /usr/bin/ss-redir
/etc/init.d/pdnsd disable
if [ -f /etc/config/ss-redir.2.6.3.bak ]; then
echo -n "恢复配置文件--------------------------------------"
cp -a /etc/config/ss-redir.2.6.3.bak /etc/config/ss-redir
rm -rf /etc/config/ss-redir.2.6.3.bak
echo -e "[\e[32m完成\e[37m]"
fi
echo -e "番茄利器插件---------------------[\e[32m全部完成\e[37m]"
rm -rf /usr/local/ss-redir.tar.gz
rm -rf /tmp/ss-redir.tar.gz
rm -rf /tmp/data/ss-redir.tar.gz		          	
else
echo -e "修改系统文件--------------------------------------[\e[31m失败\e[37m]"
echo -e "番茄利器插件-------------------------[\e[31m失败\e[37m]"
fi
else
echo -e "[\e[31m失败\e[37m]"
echo -e "番茄利器插件-------------------------[\e[31m失败\e[37m]"
fi
cd /tmp
rm -rf ThirdFlameTemp
exit