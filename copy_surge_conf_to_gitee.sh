#!/bin/zsh


source_paths=(
  "wzdnzd_aggregator_sub/Surge"
  "johnzhang0707_sub/Surge"
  "zoecsoulkey_sub/Surge"
)
to_path=../surge_conf_gitee
source_folder=$(cd "$(dirname "$0")"; pwd)

cd $to_path

./before_pull.sh

for source_path in "${source_paths[@]}"; do
  echo "source path: ${source_folder}/${source_path}"

  to_folder=${source_path%/*}
  file_name=${source_path##*/}

  echo "to: ${to_folder}/${file_name}"
  mkdir -p $to_folder
  cp $source_folder/$source_path $to_folder/$file_name

done



./after_push.sh copy_to_gitee_log.txt