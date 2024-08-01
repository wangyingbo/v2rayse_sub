#!/bin/bash

# git
git pull --rebase
echo "\n"

current_time=$(date +"Today is %A, %B %d, %Y %H:%M:%S")

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


temp_readme='wzdnzd_aggregator_README.md'
# 下载 README.md 文件内容
curl -s https://raw.githubusercontent.com/wzdnzd/aggregator/main/README.md -o $temp_readme

# 创建保存订阅链接的目录
mkdir -p wzdnzd_aggregator_sub

# 定义关键字数组
keywords=("Clash" "V2Ray" "SingBox" "Loon" "Surge" "QuantumultX")

# 遍历关键字数组
for keyword in "${keywords[@]}"; do
  # 查找包含关键字的行，并提取行内的链接
  link=$(grep "$keyword" $temp_readme | grep -o 'http[^ ]*')
  
  # 如果找到链接，下载文件并保存
  if [ -n "$link" ]; then
    echo "Downloading $link for $keyword..."
    curl -s "$link" -o "wzdnzd_aggregator_sub/$keyword"
  else
    echo "No link found for $keyword"
  fi
done

# 删除临时下载的 README.md 文件
rm $temp_readme

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
