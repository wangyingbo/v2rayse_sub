#!/bin/bash

# 输入文件和输出文件的路径
__ybdir__=$(dirname "$PWD")
input_file="test_surge.txt"
output_file="new_test_surge.txt"

# 初始化一个数组存储需要删除的字符串
declare -a removeArr

# 临时文件路径
tmp_file="${output_file}.tmp"

end_line=$(grep -n "\[Proxy Group\]" $input_file | cut -d: -f1)
# 行号计数器
line_count=0

# 读取文件并处理每一行
while IFS= read -r line; do

  # 增加行号计数器
  ((line_count++))

  if [ "$line_count" -le $end_line ]; then

    # 用英文逗号分割字符串
    IFS=',' read -r -a arr <<< "$line"

    echo "index1: ${arr[1]}"

    illegalText=${arr[1]}
    if [[ "$illegalText" =~ ^[a-zA-Z0-9\.\ ]*$ ]]; then
      # 否则，将行写入临时文件
      echo "$line" >> "$tmp_file"
    else
      # 如果包含中文，存入removeArr数组
      echo "需要被移除: ${arr[1]}"
      removeArr+=("${arr[1]}")
    fi

  else
    # 超过end_line行的部分直接写入临时文件
    echo "$line" >> "$tmp_file"
  fi

done < "$input_file"

# 遍历removeArr数组，删除对应字符串
for str in "${removeArr[@]}"; do
  # 使用 `|` 作为分隔符并转义字符串中的特殊字符
  escaped_str=$(echo "$str" | sed 's/[^^]/[&]/g; s/\^/\\^/g')
  sed -i '' -e "s|$escaped_str||g" "$tmp_file"
done


# 将处理后的内容保存到输出文件
mv "${output_file}.tmp" "$output_file"

echo "处理完成，输出文件为: $output_file"
