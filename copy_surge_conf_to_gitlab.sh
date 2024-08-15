#!/bin/zsh


source_paths=(
  "wzdnzd_aggregator_sub"
  "johnzhang0707_sub"
  "zoecsoulkey_sub"
)
to_path=../surge_conf
source_folder=$(cd "$(dirname "$0")"; pwd)

cd $to_path

echo "\n"
./before_pull.sh
echo "\n"

keywords=("Clash" "V2Ray" "SingBox" "Loon" "Surge" "QuantumultX")

for source_path in "${source_paths[@]}"; do
  for keyword in "${keywords[@]}"; do
    source_file=${source_folder}/${source_path}/${keyword}
    echo "source path: ${source_file}"
    echo "\n"

    to_folder=$source_path
    file_name=$keyword

    echo "copy to: ${to_folder}/${file_name}"
    echo "\n"

    mkdir -p $to_folder
    cp $source_file $to_folder/$file_name
  done
done

cp -r $source_folder/gist_config gist_config
cp -r $source_folder/github_config github_config


echo "\n"
./after_push.sh copy_to_gitee_log.txt