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

# 下载所有文件夹
git sparse-checkout set /*/

# 下载config.yaml文件
git sparse-checkout set config.yaml

# 完成后，显示工作目录下的文件和文件夹
echo "Downloaded files:"
ls -R

# 返回上一级目录
cd ..


