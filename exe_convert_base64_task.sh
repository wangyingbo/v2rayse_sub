#!/bin/zsh


# 转换base64订阅地址
./convert_base64_url_to_sub.sh -a https://raw.githubusercontent.com/iboxz/free-v2ray-collector/main/main/mix -f convert_base64/iboxz_free_v2ray_collector/mix -l convert_base64/iboxz_free_v2ray_collector/mix/iboxz_free_v2ray_collector_mix_log.txt
./convert_base64_url_to_sub.sh -a https://raw.githubusercontent.com/iboxz/free-v2ray-collector/main/main/trojan -f convert_base64/iboxz_free_v2ray_collector/trojan -l convert_base64/iboxz_free_v2ray_collector/trojan/iboxz_free_v2ray_collector_trojan_log.txt

./convert_base64_url_to_sub.sh -a https://raw.githubusercontent.com/itsyebekhe/HiN-VPN/main/subscription/base64/mix -f convert_base64/itsyebekhe_HiN_VPN/mix -l convert_base64/itsyebekhe_HiN_VPN/mix/itsyebekhe_HiN_VPN_mix_log.txt
./convert_base64_url_to_sub.sh -a https://raw.githubusercontent.com/itsyebekhe/HiN-VPN/main/subscription/base64/trojan -f convert_base64/itsyebekhe_HiN_VPN/trojan -l convert_base64/itsyebekhe_HiN_VPN/trojan/itsyebekhe_HiN_VPN_trojan_log.txt

./convert_base64_url_to_sub.sh -a http://103.196.20.127/api/v1/client/subscribe\?token\=786c59b0e5aea08f534779ec09978124 -f convert_base64/103_196_20_127 -l convert_base64/103_196_20_127/kuai_chi_ji_ba_log.txt