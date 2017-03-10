#!/bin/sh
cd /tmp
echo "*********************************************************"
echo "                                                         "
echo "        本插件为极路由hiwifi的SS插件                        "
echo "                                                         "
echo "      安装前：请提前关闭极路由中的L2TP/PPTP功能            "
echo "           并且卸载云平台中的SSH+插件，否则会出错          "
echo "       只测试过极路由1S的9010版本，其他版本自测            "
echo "                  出现任何问题，概不负责                  "
echo "*********************************************************"
echo "                                                         "
echo "请选择需要的操作"
echo "1:安装插件"
echo "2:卸载插件"
echo "3:退出"
read num

if [ "${num}" == "1" ]
then
cd /tmp
rm -rf install-ss.sh
wget https://github.com/xing634325131/hiwifi-ss/blob/master/install-ss.sh
chmod 777 install-ss.sh
sh install-ss.sh
fi

if [ "${num}" == "2" ]
then
cd /tmp
rm -rf uninstall-ss.sh
wget https://github.com/xing634325131/hiwifi-ss/blob/master/uninstall-ss.sh
chmod 777 uninstall-ss.sh
sh uninstall-ss.sh
fi

if [ "${num}" == "3" ]
then
exit
fi