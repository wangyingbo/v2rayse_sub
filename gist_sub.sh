#!/bin/zsh


./before_pull.sh

file_paths=(
    "https://gist.github.com/zzzZZzzZZee/6aba7c79e727a4f8f8c09085160a1490"
    "https://gist.github.com/CoreYunFeng/78d2ed8de9936081d5ad29d241b9b5c3"
    "https://gist.github.com/xiaotu9639/249910a7633a0a52367bb67fed7c10af"
    "https://gist.github.com/johnzhang0707/8f88dc294f66a68d9c4d352275a8d52d"
    "https://gist.github.com/zoecsoulkey/4fb494052c2398bdbd36df8d20fb600e"
    "https://gist.github.com/Cyndri/70a6d36206b4e3f71afad2c65aec627e"
    "https://gist.github.com/ye4241/1c93c56cd514a757cb8239b52bae3c68"
    "https://gist.github.com/CKCat/f8fec8ee8322e156a241d4819bbd4f54"
)

gist_config="gist_config"

# 遍历文件路径数组
for file_path in "${file_paths[@]}"; do
  echo "raw url: ${file_path}"
  gist_url=$file_path
  ybusername=$(echo "$gist_url" | sed -n 's|.*github.com/\([^/]\{1,\}\)/.*|\1|p')
  gist_id=$(echo "$gist_url" | sed -n 's|.*/\([^/]\{1,\}\)$|\1|p')

  echo "github username: ${ybusername}, gist id: ${gist_id}"

  # 下载Gist页面的HTML内容
  html_content=$(curl -s "$gist_url")

  # 提取所有的raw文件链接
  raw_links=$(echo "$html_content" | grep 'href=' | grep "$ybusername" | grep "$gist_id" | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep '\.yaml$' | sed 's/^/https:\/\/gist.githubusercontent.com/')

  sub_urls=$(echo $raw_links | grep '\.yaml$')
  echo "\n"
  echo "raw gist url: $sub_urls"
  echo "\n"

  echo "$sub_urls" | while read -r line ; do
    yb_file_name=$(basename $line .yaml)
    echo "per gist url: $line"
    echo "\n"
    curl $line > "${gist_config}/${ybusername}_${yb_file_name}.yaml"
    echo "\n"
  done
done

./after_push.sh $gist_config/gist_sub_log.txt