#!/bin/zsh

OS_TYPE=$(uname)
if [[ "$OSTYPE" == "darwin"* ]]; then
    # echo "运行在 macOS 上 (Running on macOS) "
    # echo "\n"
    echo "macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # echo "运行在 Linux 上 (Running on Linux) "
    # echo "\n"
    echo "Linux"
else
    # echo "未知的操作系统: $OSTYPE (Unknown OS) "
    # echo "\n"
    echo "Unknown"
fi