#!/bin/zsh
#link: https://github.com/thuhollow2/myconfig


# 设置 GitHub 仓库 URL 和目标目录
repo_url="https://github.com/thuhollow2/myconfig"
target_dir=""
# 克隆仓库到目录
target_folder="thuhollow2_myconfig"
# 检测操作系统类型
yb_device=$(./getos.sh)


if [[ $yb_device == 'macOS' ]]; then
    # 在 macOS 上执行的命令或操作
    echo "on device mac"
    # git clone --depth=1 --filter=blob:none --sparse "$repo_url" "$temp_dir"
elif [[ $yb_device == 'Linux' ]]; then
    # 在 Linux 上执行的命令或操作
    echo "on device service"
    # git clone --depth=1 --filter=blob:none "$repo_url" "$temp_dir"
else
    echo "on device Unknown"
    # git clone --depth=1 --filter=blob:none "$repo_url" "$temp_dir"
fi
echo "\n"



