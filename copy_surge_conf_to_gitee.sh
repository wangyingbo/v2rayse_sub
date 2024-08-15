#!/bin/zsh


source_paths=(
  "wzdnzd_aggregator_sub/Surge"
  "johnzhang0707_sub/Surge"
  "zoecsoulkey_sub/Surge"
)
to_path=../surge_conf_gitee


cd $to_path

./before_pull.sh

for source_path in "${source_paths[@]}"; do
  echo "source path: ${source_path}"

  cp ../v2rayse_sub/$source_path $source_path

done



./after_push.sh copy_to_gitee_log.txt