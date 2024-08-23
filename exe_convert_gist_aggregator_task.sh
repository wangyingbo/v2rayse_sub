#!/bin/zsh


# 转换gist订阅地址
./wzdnzd_aggregator.sh -a https://gist.github.com/wangyingbo/eb9075f2dc6be6a41eae7765a7fccae7 -f wzdnzd_aggregator_sub -l wzdnzd_aggregator_sub/wzdnzd_aggregator_log.txt
./wzdnzd_aggregator.sh -a https://gist.github.com/johnzhang0707/8f88dc294f66a68d9c4d352275a8d52d -f gist_aggregator/johnzhang0707_sub -l gist_aggregator/johnzhang0707_sub/johnzhang0707_log.txt
./wzdnzd_aggregator.sh -a https://gist.github.com/zoecsoulkey/4fb494052c2398bdbd36df8d20fb600e -f gist_aggregator/zoecsoulkey_sub -l gist_aggregator/zoecsoulkey_sub/zoecsoulkey_log.txt
