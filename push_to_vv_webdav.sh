#!/bin/zsh

# WebDAV 信息
WEBDAV_URL="http://webdav.nps.52wxb.top"
USERNAME="wyb"
PASSWORD="Yb123456"

# 目标文件夹
FOLDER_NAME="wzdnzd_aggregator_sub"

# 检查文件夹是否存在
if [ -d "$FOLDER_NAME" ]; then
  echo "开始上传文件夹 $FOLDER_NAME 到 $WEBDAV_URL"

  # 遍历文件夹中的所有文件
  find "$FOLDER_NAME" -type f | while read -r file; do
    # 构造 WebDAV 上的目标路径
    RELATIVE_PATH=$(echo "$file" | sed "s|^$FOLDER_NAME/||")
    TARGET_URL="$WEBDAV_URL/$RELATIVE_PATH"

    # 创建目标路径中的目录
    DIR_PATH=$(dirname "$RELATIVE_PATH")
    curl --user "$USERNAME:$PASSWORD" -X MKCOL "$WEBDAV_URL/$DIR_PATH"

    # 上传文件
    curl --user "$USERNAME:$PASSWORD" -T "$file" "$TARGET_URL"
    echo "已上传: $file 到 $TARGET_URL"
  done

  echo "上传完成！"
else
  echo "文件夹 $FOLDER_NAME 不存在"
fi
