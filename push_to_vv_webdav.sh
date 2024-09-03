#!/bin/zsh

# WebDAV 信息
YB_WEBDAV_URL="https://dav.jianguoyun.com/dav/WebDAV/test/"
YB_USERNAME=wangyingbo528@163.com
YB_PASSWORD=avahyj2vpiwxpj9g

# curl --user wangyingbo528@163.com:avahyj2vpiwxpj9g -T getos.sh https://dav.jianguoyun.com/dav/WebDAV/test/getos.sh


# WebDAV信息
# YB_WEBDAV_URL="http://webdav.nps.52wxb.top/webdav/"
# YB_USERNAME="wyb"
# YB_PASSWORD="Yb123456"

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
  local webdav_path="$YB_WEBDAV_URL$relative_path"

  echo "待上传文件路径：${file_path} 待上传文件名：${relative_path}"
  echo "上传文件: $file_path -> $webdav_path"
  echo "账号：${YB_USERNAME} 密码：${YB_PASSWORD}"
  
  curl --user "$YB_USERNAME:$YB_PASSWORD" -T $relative_path $webdav_path
  
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
