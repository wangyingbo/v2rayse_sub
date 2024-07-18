#!/bin/zsh
# link: https://github.com/changfengoss/pub


# 获取今天的日期
today=$(date +"%Y_%m_%d")
current_date=$(date +%Y%m%d)
current_time=$(date +"Today is %A, %B %d, %Y %H:%M:%S")
sub_file_name='yb_v2rayse_sub.yaml'
log_file='auto_sub_log.txt'
__ybpwd__=$PWD


# 检查是否提供了日期参数
if [ "$#" -ne 1 ]; then
    echo "没有提供日期参数，使用今天的日期：$today"
    date=$today
else
    date=$1
fi

# 设置 GitHub 仓库 URL 和目标目录
repo_url="https://github.com/changfengoss/pub"
target_dir="data/$date"

# 克隆仓库到临时目录
temp_dir=$(mktemp -d)
git clone --depth=1 --filter=blob:none --sparse "$repo_url" "$temp_dir"
cd "$temp_dir" || exit
git sparse-checkout init --cone
git sparse-checkout set "$target_dir"

# 检查目标目录是否存在
if [ ! -d "$target_dir" ]; then
    echo "指定日期的文件夹 $target_dir 不存在。"
    exit 1
fi

# 进入目标目录
cd "$target_dir" || exit

# 获取最新的 .yaml 文件内容
latest_file=$(ls -t *.yaml | head -n 1)

# 检查是否存在 .yaml 文件
if [ -z "$latest_file" ]; then
    echo "没有找到 .yaml 文件。"
    exit 1
fi

# 输出最新 .yaml 文件的内容
echo "最新的 .yaml 文件是：$latest_file"
echo "$latest_file" > ${sub_file_name}

if [ -e $sub_file_name ]; then
    echo "生成订阅配置文件：${sub_file_name}"
else
    echo "生成订阅配置文件出错"
fi

cp $sub_file_name $__ybpwd__/$sub_file_name


# 清理临时目录
rm -rf "$temp_dir"

# 回到工作目录
cd $__ybpwd__

# log
if [ -e $log_file ]; then
    echo " 存在log文件 "
else
    touch "\n" > $log_file
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

# git 
git add .
git commit -m "update!!! ${current_time}"
git push -u origin main

