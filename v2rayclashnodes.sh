#!/bin/zsh
# link: https://github.com/v2rayclashnodes/v2rayclashnodes.github.io
# link: https://v2rayclashnodes.github.io/

# git
git pull --rebase
echo "\n"

# 获取今天的日期
today=$(date +"%Y%m%d")
# 获取昨天的日期
yesterday=$today
current_date=$(date +%Y%m%d)
current_time=$(date +"Today is %A, %B %d, %Y %H:%M:%S")
year=$(date +"%Y")
month=$(date +"%m")
# 获取当前小时（24小时制）
current_hour=$(date +"%H")
sub_file_folder='v2rayclashnodes'
sub_file_name='v2rayclashnodes'
sub_category_v2ray='v2ray'
sub_category_clash='clash'
__ybpwd__=$PWD
OS_TYPE=$(uname)


if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "运行在 macOS 上 (Running on macOS) "
    echo "\n"
    yesterday=$(date -v-1d +"%Y%m%d")
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "运行在 Linux 上 (Running on Linux) "
    echo "\n"
    yesterday=$(date -d "yesterday" +"%Y%m%d")
else
    echo "未知的操作系统: $OSTYPE (Unknown OS) "
    echo "\n"
    yesterday=$(date -d "yesterday" +"%Y%m%d")
fi

if [ $current_hour -ge 8 ]; then
    echo "当前时间大于8点"
    yesterday=$today
else
    echo "当前时间小于8点"
    yesterday=$yesterday
fi
echo "\n"

# 检查是否提供了日期参数
if [ "$#" -ne 1 ]; then
    echo "没有提供日期参数，使用昨天的日期：$yesterday"
    ybdate=$yesterday
else
    ybdate=$1
fi
echo "\n"


mkdir -p $sub_file_folder/$sub_category_clash
mkdir -p $sub_file_folder/$sub_category_v2ray


# https://v2rayclashnodes.github.io/uploads/2024/08/0-20240819.yaml
for i in {0..5}
do
	clash_url="https://v2rayclashnodes.github.io/uploads/${year}/$month/$i-${ybdate}.yaml"
  	echo "Current clash download url: $clash_url"
  	echo "\n"
  	curl $clash_url > $sub_file_folder/$sub_category_clash/${sub_file_name}_clash$i.yaml
  	echo "\n"

  	v2ray_url="https://v2rayclashnodes.github.io/uploads/${year}/$month/$i-${ybdate}.txt"
  	echo "Current v2ray download url: $v2ray_url"
  	echo "\n"
  	curl $v2ray_url > $sub_file_folder/$sub_category_v2ray/${sub_file_name}_v2ray$i.txt
  	echo "\n"
done

./after_push.sh "${sub_file_folder}/${sub_file_name}_log.txt"
