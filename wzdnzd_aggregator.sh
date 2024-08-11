#!/bin/zsh
# 获取订阅：https://gist.github.com/search?o=desc&q=configsub&s=updated
# https://gist.github.com/search?o=desc&q=v2ray.txt&s=updated
# https://github.com/search?q=clash.yaml&type=repositories&s=updated&o=desc
# https://gist.github.com/search?o=desc&q=v2ray&s=updated
# https://gist.github.com/search?o=desc&q=clash&s=updated
# 订阅转换：https://my.subcloud.xyz


# git
git pull --rebase
echo "\n"

current_time=$(date +"Today is %A, %B %d, %Y %H:%M:%S")
log_file='wzdnzd_aggregator_log.txt'

# 检测操作系统类型
OS_TYPE=$(uname)
YBDEVICE=""
if [[ "$OSTYPE" == "darwin"* ]]; then
    YBDEVICE="macOS"
    # 在 macOS 上执行的命令或操作
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    YBDEVICE="Linux"
    # 在 Linux 上执行的命令或操作
else
    YBDEVICE="Unknown"
fi
echo "\n"


# 创建保存订阅链接的目录
mkdir -p wzdnzd_aggregator_sub


# ____________________________________________________________
# temp_readme='wzdnzd_aggregator_README.md'
# # 下载 README.md 文件内容
# curl -s https://raw.githubusercontent.com/wzdnzd/aggregator/main/README.md -o $temp_readme

# # 定义关键字数组
# keywords=("Clash" "V2Ray" "SingBox" "Loon" "Surge" "QuantumultX")

# # 遍历关键字数组
# for keyword in "${keywords[@]}"; do
#   # 查找包含关键字的行，并提取行内的链接
#   link=$(grep "$keyword" $temp_readme | grep -o 'http[^ ]*')
  
#   # 如果找到链接，下载文件并保存
#   if [ -n "$link" ]; then
#     echo "Downloading $link for $keyword..."
#     curl -s "$link" -o "wzdnzd_aggregator_sub/$keyword"
#   else
#     echo "No link found for $keyword"
#   fi
# done

# # 删除临时下载的 README.md 文件
# rm $temp_readme
# ____________________________________________________________


urlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  
  for (( pos=0 ; pos<strlen ; pos++ )); do
    c=${string:$pos:1}
    case "$c" in
      [a-zA-Z0-9.~_-]) encoded+="$c" ;;
      *) printf -v encoded "%s%%%02X" "$encoded" "'$c" ;;
    esac
  done
  echo "$encoded"
}

# 正确写法
url_encode() {
    encode_string=$(printf %s "$1" | xxd -p | sed 's/\(..\)/%\1/g' | tr -d '\n' | sed 's/%0a//g')
    echo $encode_string
}



# sub_url="https://gist.githubusercontent.com/zoecsoulkey/4fb494052c2398bdbd36df8d20fb600e/raw/c33cd10dd37ee6b9f670db4387746e8f6eeafde9/configsub.yaml"
# sub_url="https://gist.githubusercontent.com/johnzhang0707/8f88dc294f66a68d9c4d352275a8d52d/raw/b5d85c624e0877c471e5a10310bafe5d50fe5ccc/configsub.yaml"
# sub_url="https://gist.githubusercontent.com/wangyingbo/eb9075f2dc6be6a41eae7765a7fccae7/raw/5be56cca8504a47b66283a0ba6803c47c33b425e/yb_config_sub.yaml"



# 提供你的 Gist 页面 URL
ORI_GIST_URL="https://gist.github.com/wangyingbo/eb9075f2dc6be6a41eae7765a7fccae7"

gist_url=$ORI_GIST_URL
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

# 匹配yaml后缀结尾的url
sub_url=$(echo $raw_links | grep '\.yaml$')
echo "gist raw url: $sub_url"
echo "\n"

# 定义关键字数组
keywords=("Clash" "V2Ray" "SingBox" "Loon" "Surge" "QuantumultX")

# 遍历关键字数组
for keyword in "${keywords[@]}"; do
    # 对sub_url做encode转换
    sub_encode_url=$(urlencode $sub_url)
    # 定义配置url
    config_url="https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/${keyword}/config/ACL4SSR_Online.ini"
    # 对配置url做encode转换
    config_encode_url=$(urlencode $config_url)
    # 对keyword做小写转换
    lowercase_keyword=$(echo "$keyword" | tr '[:upper:]' '[:lower:]')
    if [[ "$lowercase_keyword" = 'quantumultx' ]]; then
        lowercase_keyword='quanx'
    fi
    link="https://yun-api.subcloud.xyz/sub?target=${lowercase_keyword}&url=${sub_encode_url}&insert=false&config=${config_encode_url}&emoji=true&list=false&tfo=false&scv=true&fdn=false&sort=false&new_name=true"

    if [[ $keyword = 'Surge' ]]; then
        # 正常link:https://yun-api.subcloud.xyz/sub?target=surge&ver=4&url=https%3A%2F%2Fgist.githubusercontent.com%2Fwangyingbo%2Feb9075f2dc6be6a41eae7765a7fccae7%2Fraw%2F5456a6eabecbafe6387b5cfd2bbaad2e0035f65b%2Fyb_config_sub.yaml&insert=false&config=https%3A%2F%2Fraw.githubusercontent.com%2FACL4SSR%2FACL4SSR%2Fmaster%2FClash%2Fconfig%2FACL4SSR_Online.ini&include=%5E(%3F%3D%5B%5E%2C%5D*(%3F%3A%E6%97%A5%E6%9C%AC%7C%E6%96%B0%E5%8A%A0%E5%9D%A1%7C%E5%8D%B0%E5%BA%A6%7C%E9%9F%A9%E5%9B%BD%7C%E9%A6%99%E6%B8%AF%7C%E7%BE%8E%E5%9B%BD%7C%E5%BE%B7%E5%9B%BD%7C%E8%8B%B1%E5%9B%BD%7C%E5%8A%A0%E6%8B%BF%E5%A4%A7%7C%E6%B3%B0%E5%9B%BD%7C%E5%8F%B0%E6%B9%BE%7C%E6%BE%B3%E5%A4%A7%E5%88%A9%E4%BA%9A%7C%E8%8D%B7%E5%85%B0%7C%E5%86%B0%E5%B2%9B%7C%E5%A2%A8%E8%A5%BF%E5%93%A5%7C%E5%B7%B4%E8%A5%BF%7C%E4%BF%84%E7%BD%97%E6%96%AF%7C%E6%84%8F%E5%A4%A7%E5%88%A9%7C%E5%B0%BC%E6%97%A5%E5%88%A9%E4%BA%9A%7C%E5%9C%9F%E8%80%B3%E5%85%B6%7C%E5%8D%A2%E6%A3%AE%E5%A0%A1%7C%E8%B6%8A%E5%8D%97%7CHK%7CJP%7CTW%7CUK%7CUS))(%3F!(%3F%3A.*%E6%9B%B4%E6%96%B0%7C.*%E5%AE%98%E7%BD%91))%5B%5E%2C%5D*&emoji=true&list=false&tfo=false&scv=true&fdn=false&sort=false
        include="^(?=[^,]*(?:日本|新加坡|印度|韩国|香港|美国|德国|英国|加拿大|泰国|台湾|澳大利亚|荷兰|冰岛|墨西哥|巴西|俄罗斯|意大利|尼日利亚|土耳其|卢森堡|越南|HK|JP|TW|UK|US))(?!(?:.*更新|.*官网))[^,]*"
        encode_include=$(url_encode $include)
        echo "encode include:${encode_include}"
        echo "\n"

        new_link="${link}&include=${encode_include}"
        link=${new_link}

    fi
  
    # 如果找到链接，下载文件并保存
    if [ -n "$link" ]; then
        echo "Downloading $link for $keyword..."
        curl -s "$link" -o "wzdnzd_aggregator_sub/$keyword"
        echo "$keyword has downloaded!"
        echo "\n"
    else
        echo "No link found for $keyword"
    fi

    # if [[ $keyword = 'Surge' ]]; then
    #     ./remove_surge_illegal.sh
    # fi
done


echo "All files downloaded to wzdnzd_aggregator/ directory."
echo "\n"

# log
if [ -e $log_file ]; then
    echo " 存在log文件 "
else
    touch "" > $log_file
fi
echo "${current_time} in ${YBDEVICE}" >> $log_file
log_num_lines=$(wc -l < "${log_file}")
if [ "$log_num_lines" -gt 100 ]; then
  tail -n 100 "${log_file}" > tmp_file
  mv tmp_file "${log_file}"
  echo "log文件超过100行，已保留后100行，多余行已删除。"
else
  echo "log文件不超过100行，无需处理。"
fi
echo "\n"


# git 
git add .
git commit -m "update in ${YBDEVICE}!!! ${current_time}"
git pull --rebase
git push -u origin main
echo "\n"
