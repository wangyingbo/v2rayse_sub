#!/bin/zsh
# link: https://github.com/changfengoss/pub


# 获取今天的日期
today=$(date +"%Y_%m_%d")
current_date=$(date +%Y%m%d)
current_time=$(date +"Today is %A, %B %d, %Y %H:%M:%S")
sub_file_name='./yb_v2rayse_sub.yaml'
log_file='./auto_sub_log.txt'

if [ -e $sub_file_name ]; then
    echo " "
else
	echo "生成订阅配置文件出错"
fi

# log
if [ -e $log_file ]; then
    echo " 存在log文件 "
else
	echo "\n" > $log_file
fi
echo $current_time >> $log_file
log_num_lines=$(wc -l < "${log_file}")
if [ "$log_num_lines" -gt 100 ]; then
  tail -n 100 "${log_file}" > tmp_file
  mv tmp_file "${log_file}"
  echo "log文件超过100行，已保留后100行，多余行已删除。"
else
  echo "log文件不超过100行，无需处理。"
fi