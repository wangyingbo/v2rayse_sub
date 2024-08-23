#!/bin/zsh


# 转换gist订阅地址
./wzdnzd_aggregator.sh -a https://gist.github.com/wangyingbo/eb9075f2dc6be6a41eae7765a7fccae7 -f wzdnzd_aggregator_sub -l wzdnzd_aggregator_sub/wzdnzd_aggregator_log.txt
./wzdnzd_aggregator.sh -a https://gist.github.com/johnzhang0707/8f88dc294f66a68d9c4d352275a8d52d -f johnzhang0707_sub -l johnzhang0707_sub/johnzhang0707_log.txt
./wzdnzd_aggregator.sh -a https://gist.github.com/zoecsoulkey/4fb494052c2398bdbd36df8d20fb600e -f zoecsoulkey_sub -l zoecsoulkey_sub/zoecsoulkey_log.txt

# 转换base64订阅地址
# ./convert_base64_url_to_sub.sh -a https://raw.githubusercontent.com/iboxz/free-v2ray-collector/main/main/mix -f iboxz_free_v2ray_collector/mix -l iboxz_free_v2ray_collector/mix/iboxz_free_v2ray_collector_mix_log.txt
# ./convert_base64_url_to_sub.sh -a https://raw.githubusercontent.com/iboxz/free-v2ray-collector/main/main/trojan -f iboxz_free_v2ray_collector/trojan -l iboxz_free_v2ray_collector/trojan/iboxz_free_v2ray_collector_trojan_log.txt

# ./convert_base64_url_to_sub.sh -a https://raw.githubusercontent.com/itsyebekhe/HiN-VPN/main/subscription/base64/mix -f itsyebekhe_HiN_VPN/mix -l itsyebekhe_HiN_VPN/mix/itsyebekhe_HiN_VPN_mix_log.txt
# ./convert_base64_url_to_sub.sh -a https://raw.githubusercontent.com/itsyebekhe/HiN-VPN/main/subscription/base64/trojan -f itsyebekhe_HiN_VPN/trojan -l itsyebekhe_HiN_VPN/trojan/itsyebekhe_HiN_VPN_trojan_log.txt

# ./convert_base64_url_to_sub.sh -a http://103.196.20.127/api/v1/client/subscribe?token=786c59b0e5aea08f534779ec09978124 -f 103_196_20_127 -l 103_196_20_127/kuai_chi_ji_ba_log.txt