# docker-kaogong

考公脑库 Docker 镜像分卷仓库（gongkao-naoku:latest，190MB）。

> 本版本基于原包修改：**用户数据目录支持环境变量指定**（见下方"用户数据持久化"）。

## 目标机部署

把本仓库 clone 下来（或下载 zip 解压），在仓库目录执行：

```bash
bash merge_gongkao.sh
```

脚本自动完成：合并 11 个分卷 → md5 校验 → `docker load`。然后按 `部署文档.md` 启动：

```bash
docker run -d --name gongkao -p 8300:8300 -v kaogong_users:/data \
  -e KAOGONG_DATA_DIR=/data \
  --restart unless-stopped gongkao-naoku:latest
```

浏览器打开 `http://<IP>:8300`。

## 用户数据持久化（本版本新增）

用户数据（账号、做题记录、收藏、笔记）全部在一个 `users.db` 文件里。
本版本支持两个环境变量指定其存放位置，优先级：

1. `KAOGONG_USERS_DB`：指定完整文件路径（如 `-e KAOGONG_USERS_DB=/data/custom.db`）
2. `KAOGONG_DATA_DIR`：指定数据目录，`users.db` 放其中（如 `-e KAOGONG_DATA_DIR=/data`）
3. 都不设置时，默认存镜像内 `/app/users.db`

目录不存在会自动创建。**推荐**配合 named volume 使用：

```bash
docker run -d --name gongkao -p 8300:8300 -v kaogong_users:/data \
  -e KAOGONG_DATA_DIR=/data --restart unless-stopped gongkao-naoku:latest
```

## 注册/游客开关（可选）

```bash
-e KAOGONG_DISABLE_REGISTER=1   # 关闭注册
-e KAOGONG_DISABLE_GUEST=1      # 关闭游客模式
```

详见 `部署文档.md`。

## 文件

- `gongkao-naoku.tar.part-aa` ~ `ak`：镜像分卷（10×19MB + 1×8.7MB）
- `merge_gongkao.sh`：合并+校验+load 一键脚本
- `部署文档.md`：完整部署/运维文档

镜像 md5：`b338cba0396ee97235992e46b2819ae9`（合并后自动校验）
