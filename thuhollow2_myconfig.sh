#!/bin/zsh
#link: https://github.com/thuhollow2/myconfig


# 设置 GitHub 仓库 URL 和目标目录
repo_url="https://github.com/thuhollow2/myconfig"
# 克隆仓库到目录
target_folder="myconfig"
# 检测操作系统类型
yb_device=$(./getos.sh)


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

# 克隆仓库的元数据
git clone --depth=1 --filter=blob:none --sparse "$repo_url"

# 进入仓库目录
cd $target_folder || { echo "Failed to enter the repository directory"; cd ..; exit 1; }

# 初始化稀疏检出
git sparse-checkout init --cone

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

# 将所有文件夹和config.yaml文件一次性设置到sparse-checkout中
git sparse-checkout set $folders $files

# 完成后，显示工作目录下的文件和文件夹
echo "Downloaded files:"
ls -R

rm -rf .git

# 返回上一级目录
cd ..

./after_push.sh "${target_folder}/thuhollow2_myconfig_log.txt"

