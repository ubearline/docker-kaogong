#!/bin/bash
# 考公脑库镜像分卷合并脚本 —— 在目标机执行
# 用法：把 gongkao-naoku.tar.part-aa ~ ak 共 11 个分卷和本脚本放同一目录，运行：
#   bash merge_gongkao.sh
# 合并后自动校验 md5 并 docker load
set -e
cd "$(dirname "$0")"

OUT=gongkao-naoku.tar
MD5=434b177b171323d6f225d204241522ed

echo "[1/3] 合并 12 个分卷 -> $OUT"
cat $OUT.part-* > $OUT

echo "[2/3] 校验 md5"
ACTUAL=$(md5sum $OUT | awk '{print $1}')
if [ "$ACTUAL" != "$MD5" ]; then
    echo "校验失败：actual=$ACTUAL expected=$MD5（分卷可能下载不完整，重下坏的那个再试）"
    exit 1
fi
echo "校验通过"

echo "[3/3] docker load"
docker load -i $OUT
echo "完成。运行：docker run -d --name gongkao -p 8300:8300 -v kaogong_users:/data --restart unless-stopped gongkao-naoku:latest"
