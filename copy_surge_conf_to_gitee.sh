#!/bin/zsh


source_paths=(
  "wzdnzd_aggregator_sub/Surge"
  "johnzhang0707_sub/Surge"
  "zoecsoulkey_sub/Surge"
)
to_path=../surge_conf_gitee

for source_path in "${source_paths[@]}"; do
  echo "source path: ${source_path}"

  copy $source_path $to_path/$source_path

done

cd $to_path

./after_push.sh copy_to_gitee_log.txt