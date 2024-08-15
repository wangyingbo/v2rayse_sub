#!/bin/zsh


source_paths=(
  "wzdnzd_aggregator_sub/Surge"
  "johnzhang0707_sub/Surge"
  "zoecsoulkey_sub/Surge"
)
to_path=../surge_conf_gitee
source_folder=$(cd "$(dirname "$0")"; pwd)

cd $to_path

echo "\n"
./before_pull.sh
echo "\n"

for source_path in "${source_paths[@]}"; do

  echo "source path: ${source_folder}/${source_path}"
  echo "\n"

  to_folder=${source_path%/*}
  file_name=${source_path##*/}

  echo "copy to: ${to_folder}/${file_name}"
  echo "\n"

  mkdir -p $to_folder
  cp $source_folder/$source_path $to_folder/$file_name

done


echo "\n"
./after_push.sh copy_to_gitee_log.txt