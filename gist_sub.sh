#!/bin/zsh
# fork list: https://github.com/wzdnzd/aggregator/forks
# fork list recently updated: https://github.com/wzdnzd/aggregator/forks?include=active&page=1&period=2y&sort_by=last_updated

./before_pull.sh

gist_file_paths=(
    "https://gist.github.com/zzzZZzzZZee/6aba7c79e727a4f8f8c09085160a1490"
    "https://gist.github.com/CoreYunFeng/78d2ed8de9936081d5ad29d241b9b5c3"
    "https://gist.github.com/xiaotu9639/249910a7633a0a52367bb67fed7c10af"
    "https://gist.github.com/johnzhang0707/8f88dc294f66a68d9c4d352275a8d52d"
    "https://gist.github.com/zoecsoulkey/4fb494052c2398bdbd36df8d20fb600e"
    "https://gist.github.com/Cyndri/70a6d36206b4e3f71afad2c65aec627e"
    "https://gist.github.com/ye4241/1c93c56cd514a757cb8239b52bae3c68"
    "https://gist.github.com/CKCat/f8fec8ee8322e156a241d4819bbd4f54"
    "https://gist.github.com/mayojoy/88b2863888eadb08b16ea54316c07717"
)

github_file_paths=(
  "https://raw.githubusercontent.com/qjlxg/aggregator/main/data/clash.yaml"
)

gist_config="gist_config"

# 遍历文件路径数组
for gist_file_path in "${gist_file_paths[@]}"; do
  echo "raw url: ${gist_file_path}"
  gist_url=$gist_file_path
  ybusername=$(echo "$gist_url" | sed -n 's|.*github.com/\([^/]\{1,\}\)/.*|\1|p')
  gist_id=$(echo "$gist_url" | sed -n 's|.*/\([^/]\{1,\}\)$|\1|p')

  echo "github username: ${ybusername}, gist id: ${gist_id}"

  # 下载Gist页面的HTML内容
  html_content=$(curl -s "$gist_url")

  # 提取所有的raw文件链接
  raw_links=$(echo "$html_content" | grep 'href=' | grep "$ybusername" | grep "$gist_id" | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep '\.yaml$' | sed 's/^/https:\/\/gist.githubusercontent.com/')

  sub_urls=$(echo $raw_links | grep '\.yaml$')
  echo "\n"
  echo "gist raw url: $sub_urls"
  echo "\n"

  echo "$sub_urls" | while read -r line ; do
    yb_file_name=$(basename $line .yaml)
    echo "per gist url: $line"
    echo "\n"
    curl $line > "${gist_config}/${ybusername}_${yb_file_name}.yaml"
    echo "\n"
  done
done


for git_file_path in "${github_file_paths[@]}"; do
  echo "github raw url: ${git_file_path}"
  git_username=$(echo $git_file_path | cut -d'/' -f4)
  git_project=$(echo $git_file_path | cut -d'/' -f5)
  git_filename=$(echo $git_file_path | rev | cut -d'/' -f1 | rev)
  echo "github ----> 用户名: $git_username 项目名: $git_project 文件名: $git_filename"
  echo "\n"
  curl $git_file_path > "${gist_config}/${git_username}_${git_project}_${git_filename}.yaml"
  echo "\n"
done


# others
curl "http://172.245.30.41/clash.yaml" > "${gist_config}/172_245_30_41_clash.yaml"
curl "http://172.245.30.41/v2ray.txt" > "${gist_config}/172_245_30_41_v2ray.txt"
curl "http://172.245.30.41/singbox.json" > "${gist_config}/172_245_30_41_singbox.json"


# base64订阅: https://github.com/Surfboardv2ray/Proxy-sorter
curl "https://yun-api.subcloud.xyz/sub?target=clash&url=https%3A%2F%2Fraw.githubusercontent.com%2FSurfboardv2ray%2FProxy-sorter%2Fmain%2Fsubmerge%2Fconverted.txt&insert=false&config=https%3A%2F%2Fraw.githubusercontent.com%2FACL4SSR%2FACL4SSR%2Fmaster%2FClash%2Fconfig%2FACL4SSR_Online.ini&emoji=true&list=false&tfo=false&scv=true&fdn=false&sort=false&new_name=true" "${gist_config}/Surfboardv2ray_Proxy-sorter_clash.yaml"


./after_push.sh "${gist_config}/gist_sub_log.txt"