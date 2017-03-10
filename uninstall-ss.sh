#!/bin/sh
echo "开始卸载番茄利器插件"
echo -e "停止相关进程--------------------------------------\c"
/etc/init.d/ss-redir stop 1>/dev/null 2>&1
/etc/init.d/ss-redir disable 1>/dev/null 2>&1
/etc/init.d/ss.sh stop 1>/dev/null 2>&1
/etc/init.d/ss.sh disable 1>/dev/null 2>&1
/etc/init.d/pdnsd stop 1>/dev/null 2>&1
rm -rf /etc/dnsmasq.d/* 1>/dev/null 2>&1
/etc/init.d/dnsmasq restart 1>/dev/null 2>&1
echo -e "[\e[32m完成\e[37m]"
echo -e "删除相关文件--------------------------------------\c"
rm -rf /etc/init.d/ss-redir
rm -rf /etc/init.d/ss.sh
rm -rf /usr/bin/ss-redir
rm -rf /etc/SSdiyDNS.conf
rm -rf /etc/THPdnsd-part.conf
rm -rf /etc/ThirdFlameDNS.conf
rm -rf /etc/antixxxdns.conf
rm -rf /usr/lib/lua/luci/view/app/th/shadowsocks.htm
rm -rf /usr/lib/lua/luci/controller/app/th.lua
rm -rf /lib/upgrade/keep.d/ss-redir
rm -rf /usr/lib/lua/luci/controller/app/vendor.lua
rm -rf /usr/lib/lua/luci/view/app/vendor/ss.htm
rm -rf /usr/lib/lua/luci/view/app/vendor/ss_ajax.htm
rm -rf /usr/bin/vendor
echo -e "[\e[32m完成\e[37m]"
echo -e "清除IPTABLES规则----------------------------------\c"
iptables -t nat -D PREROUTING -p udp -j dnsmask-PREROUTING 2>/dev/null
iptables -t nat -F dnsmask-PREROUTING 2>/dev/null
iptables -t nat -X dnsmask-PREROUTING 2>/dev/null
iptables -t nat -D PREROUTING -i br-lan -j ssgoabroad 2>/dev/null
iptables -t nat -F ssgoabroad 2>/dev/null
iptables -t nat -X ssgoabroad 2>/dev/null
iptables -t nat -D PREROUTING -i ppp+ -j ssgoabroad-ppp 2>/dev/null
iptables -t nat -F ssgoabroad-ppp 2>/dev/null
iptables -t nat -X ssgoabroad-ppp 2>/dev/null
iptables -t nat -D OUTPUT -p tcp -j ssgoabroad-OUTPUT 2>/dev/null
iptables -t nat -F ssgoabroad-OUTPUT 2>/dev/null
iptables -t nat -X ssgoabroad-OUTPUT 2>/dev/null
echo -e "[\e[32m完成\e[37m]"
echo -e "还原系统文件--------------------------------------\c"
if [ -f /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm.bak ]; then
rm -rf /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm
mv /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm.bak /usr/lib/lua/luci/view/admin_web/menu/adv_menu.htm
fi
echo -e "[\e[32m完成\e[37m]"
echo -n "修正配置界面--------------------------------------"
sed -i 's/height:629/height:590/g' /usr/lib/lua/luci/view/admin_web/home.htm;
sed -i 's/.setup_box{ margin-left: 169px; height: 496px;/.setup_box{ margin-left: 169px; height: 460px;/g' /www/turbo-static/turbo/web/css/style.css;
echo -e "[\e[32m完成\e[37m]"
echo -n "清除LUCI缓存--------------------------------------"
rm -rf /tmp/luci-indexcache
echo -e "[\e[32m完成\e[37m]"
read -n1 -p "是否删除配置文件,请输入[Y/N]?" yn
echo ""
if [ "$yn" == "Y" ] || [ "$yn" == "y" ]; then
echo -n "删除配置文件--------------------------------------"
rm -rf /etc/config/ss-redir
rm -rf /tmp/white_domain_list.conf
echo -e "[\e[32m完成\e[37m]"
else
mkdir -p /usr/bin/vendor/config
fi
echo -e "卸载番茄利器插件-----------------[\e[32m全部完成\e[37m]"
exit