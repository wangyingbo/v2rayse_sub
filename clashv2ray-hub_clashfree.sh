#!/bin/zsh
# clash订阅链接
# https://a.nodeshare.xyz/uploads/2025/2/20250224.yaml
# v2ray订阅链接:
# https://a.nodeshare.xyz/uploads/2025/2/20250224.txt
# sing-box订阅链接
# https://a.nodeshare.xyz/uploads/2025/2/20250224.json



# git
./before_pull.sh

# 获取今天的日期
today=$(date +"%Y%m%d")
# 获取上次的日期
last_day=$today
current_date=$(date +%Y%m%d)
current_time=$(date +"Today is %A, %B %d, %Y %H:%M:%S")
year=$(date +"%Y")
month=$(date +"%-m")
last_month=$month
last_year=$year
# 获取当前小时（24小时制）
current_hour=$(date +"%H")
sub_file_folder='clashv2ray-hub_clashfree_sub'
last_avaliable_dir="$sub_file_folder/last_url.txt"
sub_file_name='clashfree'
sub_category_v2ray='v2ray'
sub_category_clash='clash'
sub_category_singbox='singbox'
__ybpwd__=$PWD
OS_TYPE=$(uname)


echo "\n"
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "运行在 macOS 上 (Running on macOS) "
    echo "\n"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "运行在 Linux 上 (Running on Linux) "
    echo "\n"
else
    echo "未知的操作系统: $OSTYPE (Unknown OS) "
    echo "\n"
fi

last_avaliable_url=$(cat $last_avaliable_dir)
dirname_url=$(dirname $last_avaliable_url)
last_month=$(basename $dirname_url)
last_year=$(basename $(dirname $dirname_url))

last_avaliable_filename=$(basename $last_avaliable_url)
name_without_extension="${last_avaliable_filename%.*}"
last_day=$name_without_extension


echo "上次可用的 year: ${last_year}  month: ${last_month}  day: ${last_day}"
echo "\n"

# 检查是否提供了日期参数
if [ "$#" -ne 1 ]; then
    echo "没有提供日期参数，使用昨天的日期：$last_day"
    ybdate=$last_day
else
    ybdate=$1
fi
echo "\n"


mkdir -p $sub_file_folder


# 定义一个函数来判断 URL 是否有效
check_url_validity() {
    url=$1  # 获取传入的 URL
    http_response=$(curl -o /dev/null -s -w "%{http_code}" "$url")
    if [ "$http_response" -eq 200 ]; then
        echo "200"  # URL 有效
    else
        echo "100"  # URL 无效
    fi
}

# param1: clash|v2ray|singbox   param2: 后缀
downloadsub() {
    echo "\n"
    echo "====================="
    today_url="https://a.nodeshare.xyz/uploads/${year}/${month}/${today}.$2"
    last_url="https://a.nodeshare.xyz/uploads/${last_year}/${last_month}/${ybdate}.$2"
    final_url=$today_url

    echo "Current $1 taday download url: $today_url"
    echo "Current $1 last avaliable download url: $last_url"

    check_url_validity $today_url
    # 获取返回值并判断
    if [ $? -eq 200 ]; then
        final_url=$today_url
    else
        final_url=$last_url
    fi

    echo "\n"
    echo "Current $1 final download url: $final_url"
    echo "\n"

    curl $final_url > $sub_file_folder/${sub_file_name}_$1.$2

    # 写入最新的可用的url
    echo $final_url > $last_avaliable_dir
    
    echo "====================="
    echo "\n"
}

downloadsub $sub_category_clash yaml
downloadsub $sub_category_v2ray txt
downloadsub $sub_category_singbox json


./after_push.sh "${sub_file_folder}/${sub_file_name}_log.txt"
