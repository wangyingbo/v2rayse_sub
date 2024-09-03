#!/bin/bash

# WebDAV 信息
WEBDAV_URL="http://webdav.nps.52wxb.top"
USERNAME="admin"
PASSWORD="SDYZxl2721020990"

# 目标文件夹
FOLDER_NAME="wzdnzd_aggregator_sub"

# 检查文件夹是否存在
if [ -d "$FOLDER_NAME" ]; then
  echo "开始上传文件夹 $FOLDER_NAME 到 $WEBDAV_URL"

  # 使用 cadaver 命令行 WebDAV 客户端来上传文件夹
  cadaver <<EOF
open $WEBDAV_URL
username $USERNAME
password $PASSWORD
cd /
put $FOLDER_NAME/*
quit
EOF

  echo "上传完成！"
else
  echo "文件夹 $FOLDER_NAME 不存在"
fi
