#!/bin/zsh
# link1: https://github.com/tglaoshiji/nodeshare		
# link2: https://telegeam.github.io/clashv2rayshare/
# link3: https://tglaoshiji.github.io/nodeshare/2024/7/20240726.yaml


./before_pull.sh


# 获取今天的日期
today=$(date +"%Y_%m_%d")
current_date=$(date +%Y%m%d)
# 获取昨天的日期
yesterday_date=$current_date
current_time=$(date +"Today is %A, %B %d, %Y %H:%M:%S")
tglaoshiji_foler='tglaoshiji'
sub_file_name='tglaoshiji.yaml'
log_file='tglaoshiji_log.txt'
year=$(date +"%Y")
month=$(date +"%-m")
# 获取当前小时（24小时制）
current_hour=$(date +"%H")

mkdir -p $tglaoshiji_foler

# 检测操作系统类型
OS_TYPE=$(uname)
YBDEVICE=""
if [[ "$OSTYPE" == "darwin"* ]]; then
    YBDEVICE="macOS"
    # 在 macOS 上执行的命令或操作
    yesterday_date=$(date -v-1d +"%Y%m%d")
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    YBDEVICE="Linux"
    # 在 Linux 上执行的命令或操作
    yesterday_date=$(date -d "yesterday" +"%Y%m%d")
else
    YBDEVICE="Unknown"
    yesterday_date=$(date -d "yesterday" +"%Y%m%d")
fi
echo "\n"


my_date=$yesterday_date
if [ $current_hour -ge 18 ]; then
    echo "当前时间大于下午6点"
    my_date=$current_date
else
    echo "当前时间小于下午6点"
    my_date=$yesterday_date
fi
echo "\n"

# url="https://tglaoshiji.github.io/nodeshare/${year}/${month}/${my_date}.yaml"
url="https://tglaoshiji.github.io/nodeshare/${year}/7/${my_date}.yaml"

echo "当前的请求地址是：${url}"
echo "\n"

curl $url > $tglaoshiji_foler/$sub_file_name

./after_push.sh "${tglaoshiji_foler}/${log_file}"