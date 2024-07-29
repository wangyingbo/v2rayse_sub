#!/bin/zsh
# link1: https://github.com/tglaoshiji/nodeshare		
# link2: https://telegeam.github.io/clashv2rayshare/
# link3: https://tglaoshiji.github.io/nodeshare/2024/7/20240726.yaml


# git
git pull --rebase
echo "\n"


# 获取今天的日期
today=$(date +"%Y_%m_%d")
current_date=$(date +%Y%m%d)
# 获取昨天的日期
yesterday_date=$current_date
current_time=$(date +"Today is %A, %B %d, %Y %H:%M:%S")
sub_file_name='tglaoshiji.yaml'
log_file='tglaoshiji_log.txt'
year=$(date +"%Y")
month=$(date +"%-m")
# 获取当前小时（24小时制）
current_hour=$(date +"%H")


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
    # my_date=$current_date
    my_date=$yesterday_date
else
    echo "当前时间小于下午6点"
    my_date=$yesterday_date
fi
echo "\n"

url="https://tglaoshiji.github.io/nodeshare/${year}/${month}/${my_date}.yaml"

curl $url > ./$sub_file_name

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