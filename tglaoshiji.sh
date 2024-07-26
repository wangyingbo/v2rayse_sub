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
current_time=$(date +"Today is %A, %B %d, %Y %H:%M:%S")
sub_file_name='tglaoshiji.yaml'
log_file='auto_sub_tglaoshiji_log.txt'
year=$(date +"%Y")
month=$(date +"%-m")


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


url="https://tglaoshiji.github.io/nodeshare/${year}/${month}/${current_date}.yaml"

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