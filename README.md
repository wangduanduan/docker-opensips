# OpenSIPS Docker Image

## 特点

- 基于官方源码构建
- 内置rsyslog, 将日志写入/var/log/opensips.log
- 内置logrogate定时任务，定时回滚opensips.log
- 内置opensips-cli

## 构建镜像

```sh
make build
```

构建额外的模块

```sh
BUILD_MOD=db_mysql make build
```

运行镜像
```sh
make run
```

进入容器
```sh
make exec
```
