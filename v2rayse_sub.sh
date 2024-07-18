#!/bin/bash
# link: https://github.com/changfengoss/pub


# 获取今天的日期
today=$(date +"%Y_%m_%d")

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
cat "$latest_file"

# 清理临时目录
rm -rf "$temp_dir"
