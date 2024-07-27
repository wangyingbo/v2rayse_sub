#!/bin/zsh
# link: https://github.com/changfengoss/pub


# git
git pull --rebase
echo "\n"

# 获取今天的日期
today=$(date +"%Y_%m_%d")
# 获取昨天的日期
yesterday=$today
current_date=$(date +%Y%m%d)
current_time=$(date +"Today is %A, %B %d, %Y %H:%M:%S")
sub_file_name='yb_v2rayse_sub.yaml'
log_file='v2rayse_sub_log.txt'
__ybpwd__=$PWD
OS_TYPE=$(uname)


if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "运行在 macOS 上 (Running on macOS) "
    echo "\n"
    yesterday=$(date -v-1d +"%Y_%m_%d")
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "运行在 Linux 上 (Running on Linux) "
    echo "\n"
    yesterday=$(date -d "yesterday" +"%Y_%m_%d")
else
    echo "未知的操作系统: $OSTYPE (Unknown OS) "
    echo "\n"
    yesterday=$(date -d "yesterday" +"%Y_%m_%d")
fi


# 检查是否提供了日期参数
if [ "$#" -ne 1 ]; then
    echo "没有提供日期参数，使用昨天的日期：$yesterday"
    ybdate=$yesterday
else
    ybdate=$1
fi
echo "\n"

# 设置 GitHub 仓库 URL 和目标目录
repo_url="https://github.com/changfengoss/pub"
target_dir="data/$ybdate"

# 克隆仓库到临时目录
temp_dir=$(mktemp -d)

# 检测操作系统类型
YBDEVICE=""
if [[ "$OSTYPE" == "darwin"* ]]; then
    YBDEVICE="macOS"
    # 在 macOS 上执行的命令或操作
    git clone --depth=1 --filter=blob:none --sparse "$repo_url" "$temp_dir"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    YBDEVICE="Linux"
    # 在 Linux 上执行的命令或操作
    git clone --depth=1 --filter=blob:none "$repo_url" "$temp_dir"
else
    YBDEVICE="Unknown"
    git clone --depth=1 --filter=blob:none "$repo_url" "$temp_dir"
fi
echo "\n"

cd "$temp_dir" || exit
git sparse-checkout init --cone
git sparse-checkout set "$target_dir"

# 检查目标目录是否存在
if [ ! -d "$target_dir" ]; then
    echo "指定日期的文件夹 $target_dir 不存在。"
    echo "\n"
    exit 1
fi

# 进入目标目录
cd "$target_dir" || exit

# 创建缓存文件夹中的 top_size 文件夹
top_folder_name="top_size"
top_folder_path="$temp_dir/$target_dir/${top_folder_name}"
mkdir -p $top_folder_path

echo "\n"
echo "当前路径: $PWD"
echo "列出所有: "
ls
echo "\n"

# 获取最新的 .yaml 文件内容
latest_file=$(ls -t *.yaml | head -n 1)

# 检查是否存在 .yaml 文件
if [ -z "$latest_file" ]; then
    echo "没有找到 .yaml 文件。"
    exit 1
fi

# 输出最新 .yaml 文件的内容
echo "最新的 .yaml 文件是：$latest_file"
echo "\n"

cat $latest_file > ${sub_file_name}

if [ -e $sub_file_name ]; then
    echo "生成订阅配置文件：${sub_file_name}"
else
    echo "生成订阅配置文件出错"
fi
echo "\n"

# 查找前 5 个文件大小最大的 .yaml 文件并复制到缓存文件夹的 top_size 子文件夹中
yaml_files=($(ls -S *.yaml | head -n 5))
count=1
for file in "${yaml_files[@]}"; do
    echo "${file}" > $top_folder_path/test_desc.txt
    cp "$file" "$top_folder_path/yb_v2rayse_sub$count.yaml"
    count=$((count + 1))
done

# 输出结果
echo "前 5 个文件大小最大的 .yaml 文件已复制到缓存文件夹的 ${top_folder_name} 子文件夹中，并重命名为 yb_v2rayse_sub 加序号。"

cp $sub_file_name $__ybpwd__/$sub_file_name
cp -r $top_folder_path $__ybpwd__

echo "\n"

# 清理临时目录
# rm -rf "$temp_dir"

# 回到工作目录
cd $__ybpwd__

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

