#!/bin/zsh


./before_pull.sh

github_config="github_config"
mkdir -p $github_config

# others
curl "http://172.245.30.41/clash.yaml" > "${github_config}/172_245_30_41_clash.yaml"
curl "http://172.245.30.41/v2ray.txt" > "${github_config}/172_245_30_41_v2ray.txt"
curl "http://172.245.30.41/singbox.json" > "${github_config}/172_245_30_41_singbox.json"


# base64订阅: https://github.com/Surfboardv2ray/Proxy-sorter
curl "https://yun-api.subcloud.xyz/sub?target=clash&url=https%3A%2F%2Fraw.githubusercontent.com%2FSurfboardv2ray%2FProxy-sorter%2Fmain%2Fsubmerge%2Fconverted.txt&insert=false&config=https%3A%2F%2Fraw.githubusercontent.com%2FACL4SSR%2FACL4SSR%2Fmaster%2FClash%2Fconfig%2FACL4SSR_Online.ini&emoji=true&list=false&tfo=false&scv=true&fdn=false&sort=false&new_name=true" > "${github_config}/Surfboardv2ray_Proxy-sorter_clash.yaml"



./after_push.sh "${github_config}/github_sub_log.txt"