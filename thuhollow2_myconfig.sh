#!/bin/zsh
#link: https://github.com/thuhollow2/myconfig


# 设置 GitHub 仓库 URL 和目标目录
repo_url="https://github.com/thuhollow2/myconfig"
# 克隆仓库到目录
target_folder="thuhollow2_myconfig"
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

# 克隆仓库的元数据
git clone --depth=1 --filter=blob:none --sparse "$repo_url"

# 进入仓库目录
cd myconfig || { echo "Failed to enter the repository directory"; cd ..; exit 1; }

# 初始化稀疏检出
git sparse-checkout init --cone

# 获取所有顶层目录和文件
folders=$(git ls-tree -d --name-only HEAD)
files=$(git ls-tree -r HEAD --name-only | grep 'config.yaml')

# 设置稀疏检出，逐一下载顶层文件夹及config.yaml
for folder in $folders; do
    echo "folder enum: ${folder}"
    git sparse-checkout set "$folder"
done

# 下载config.yaml文件
if [ -n "$files" ]; then
    git sparse-checkout set $files
fi

# 完成后，显示工作目录下的文件和文件夹
echo "Downloaded files:"
ls -R

# 返回上一级目录
cd ..


