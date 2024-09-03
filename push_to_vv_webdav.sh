#!/bin/zsh

# WebDAV 信息
WEBDAV_URL="https://dav.jianguoyun.com/dav/WebDAV/test" # http://webdav.nps.52wxb.top
USERNAME="wangyingbo528@163.com" # wyb
PASSWORD="avahyj2vpiwxpj9g" # Yb123456



# WebDAV信息
WEBDAV_URL="http://webdav.nps.52wxb.top/webdav"
USERNAME="wyb"
PASSWORD="Yb123456"
FOLDER_NAME="wzdnzd_aggregator_sub"

# 检查文件夹是否存在
if [ ! -d "$FOLDER_NAME" ]; then
  echo "文件夹 $FOLDER_NAME 不存在"
  exit 1
fi

# 使用curl上传文件夹到WebDAV
upload_to_webdav() {
  local file_path="$1"
  local relative_path="${file_path#./}"  # 去掉文件路径的前缀 ./
  local webdav_path="$WEBDAV_URL$relative_path"
  
  echo "上传文件: $file_path -> $webdav_path"
  
  curl -u "$USERNAME:$PASSWORD" -T "$file_path" "$webdav_path"
  
  if [ $? -ne 0 ]; then
    echo "上传失败: $file_path"
  else
    echo "上传成功: $file_path"
  fi
}

# 遍历文件夹并上传
find "$FOLDER_NAME" -type f | while read file; do
  upload_to_webdav "$file"
done

echo "所有文件上传完成。"
