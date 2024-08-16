#!/bin/zsh


# 转换gist订阅地址
./wzdnzd_aggregator.sh -a https://gist.github.com/wangyingbo/eb9075f2dc6be6a41eae7765a7fccae7 -f wzdnzd_aggregator_sub -l wzdnzd_aggregator_sub/wzdnzd_aggregator_log.txt
./wzdnzd_aggregator.sh -a https://gist.github.com/johnzhang0707/8f88dc294f66a68d9c4d352275a8d52d -f johnzhang0707_sub -l johnzhang0707_sub/johnzhang0707_log.txt
./wzdnzd_aggregator.sh -a https://gist.github.com/zoecsoulkey/4fb494052c2398bdbd36df8d20fb600e -f zoecsoulkey_sub -l zoecsoulkey_sub/zoecsoulkey_log.txt

# 转换base64订阅地址
./convert_base64_url_to_sub.sh -a https://raw.githubusercontent.com/iboxz/free-v2ray-collector/main/main/mix -f iboxz_free_v2ray_collector -l iboxz_free_v2ray_collector/iboxz_free_v2ray_collector_log.txt
./convert_base64_url_to_sub.sh -a https://raw.githubusercontent.com/iboxz/free-v2ray-collector/main/main/trojan -f iboxz_free_v2ray_collector_trojan -l iboxz_free_v2ray_collector_trojan/iboxz_free_v2ray_collector_trojan_log.txt