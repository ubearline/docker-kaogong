# docker-kaogong

考公脑库 Docker 镜像分卷仓库（gongkao-naoku:latest，约 220MB，2026-10-28 重建：users.db 落盘目录改由 KAOGONG_DATA_DIR 指定并实测生效）。

## 目标机部署

把本仓库 clone 下来（或下载 zip 解压），在仓库目录执行：

```bash
bash merge_gongkao.sh
```

脚本自动完成：合并 11 个分卷 → md5 校验 → `docker load`。然后按 `部署文档.md` 启动：

```bash
docker run -d --name gongkao -p 8300:8300 -v kaogong_users:/data \
  --restart unless-stopped gongkao-naoku:latest
```

浏览器打开 `http://<IP>:8300`。

## 注册/游客开关（可选）

```bash
-e KAOGONG_DISABLE_REGISTER=1   # 关闭注册
-e KAOGONG_DISABLE_GUEST=1      # 关闭游客模式
```

详见 `部署文档.md`。

## 文件

- `gongkao-naoku.tar.part-aa` ~ `al`：镜像分卷（11×19MB + 1×10.6MB）
- `merge_gongkao.sh`：合并+校验+load 一键脚本
- `部署文档.md`：完整部署/运维文档

镜像 md5：`434b177b171323d6f225d204241522ed`（合并后自动校验）
