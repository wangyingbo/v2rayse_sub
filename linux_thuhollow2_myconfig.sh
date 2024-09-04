#!/bin/zsh
#link: https://github.com/thuhollow2/myconfig


# 设置 GitHub 仓库 URL 和目标目录
repo_url="https://github.com/thuhollow2/myconfig"
# 克隆仓库到目录
target_folder="myconfig"
# 检测操作系统类型
yb_device=$(./getos.sh)

echo "\n"
if [[ $yb_device == 'macOS' ]]; then
    # 在 macOS 上执行的命令或操作
    echo "on device mac"
elif [[ $yb_device == 'Linux' ]]; then
    # 在 Linux 上执行的命令或操作
    echo "on device service"
else
    echo "on device Unknown"
fi
echo "\n"

./before_pull.sh

if [[ -d $target_folder ]]; then
    echo "\n"
    echo "${target_folder} has exist!!!"
    echo "\n"
    rm -rf $target_folder
fi

# 克隆仓库的元数据
# if [[ $yb_device == 'macOS' ]]; then
#     git clone --depth=1 --filter=blob:none --sparse "$repo_url"
# else
#     git clone --depth=1 --filter=blob:none "$repo_url"
# fi

git clone  "$repo_url"


if [[ -d $target_folder ]]; then
    echo "\n"
else 
    echo "${target_folder} not exist!!"
    exit 1
fi



# -------------------------------------------------------------


# 进入仓库目录
cd $target_folder

# 获取所有顶层目录和文件
folders=($(git ls-tree -d --name-only HEAD))
files=$(git ls-tree -r HEAD --name-only | grep 'config.yaml')

# 打印所有文件夹（用于调试）
echo "Found folders:"
for folder in "${folders[@]}"; do
  echo "$folder"
done

# # 逐一下载每个文件夹
# for folder in "${folders[@]}"; do
#     echo "$folder"
#     git sparse-checkout set "$folder"
# done

# # 下载config.yaml文件
# if [ -n "$files" ]; then
#     git sparse-checkout set $files
# fi


# 完成后，显示工作目录下的文件和文件夹
echo "Downloaded files:"
ls -R
echo "\n"

# 返回上一级目录
cd ..


# -------------------------------------------------------------

rm -rf ${target_folder}/.git

./after_push.sh "${target_folder}/thuhollow2_myconfig_log.txt"

