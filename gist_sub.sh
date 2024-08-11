#!/bin/bash


./before_pull.sh

file_paths=(
    "https://gist.github.com/zzzZZzzZZee/6aba7c79e727a4f8f8c09085160a1490"
    "https://gist.github.com/CoreYunFeng/78d2ed8de9936081d5ad29d241b9b5c3"
    "https://gist.github.com/xiaotu9639/249910a7633a0a52367bb67fed7c10af"
    "https://gist.github.com/johnzhang0707/8f88dc294f66a68d9c4d352275a8d52d"
    "https://gist.github.com/zoecsoulkey/4fb494052c2398bdbd36df8d20fb600e"
)

gist_config="gist_config"

# 遍历文件路径数组
for file_path in "${file_paths[@]}"; do
    gist_url=$file_path
    regex="https://gist.github.com/([^/]+)/([^/]+)"
    if [[ $gist_url =~ $regex ]]; then
      username="${BASH_REMATCH[1]}"
      gist_id="${BASH_REMATCH[2]}"
    else
      echo "Invalid Gist URL"
      exit 1
    fi

    # 下载Gist页面的HTML内容
    html_content=$(curl -s "$gist_url")

    # 提取所有的raw文件链接
    raw_links=$(echo "$html_content" | grep 'href=' | grep "$username" | grep "$gist_id" | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep '\.yaml$' | sed 's/^/https:\/\/gist.githubusercontent.com/')

    sub_url=$(echo $raw_links | grep '\.yaml$')
    echo "\n"
    echo "raw gist url: $sub_url"
    echo "\n"
    echo "\n"

    curl $sub_url > $gist_config/$username.yaml
done

./after_push.sh gist_sub_log.txt