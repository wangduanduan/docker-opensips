# opensips 版本
OPENSIPS_VERSION=3.5.6

# 源码下载地址
OPENSIPS_URL=https://download.opensips.org/opensips-$(OPENSIPS_VERSION).tar.gz

# 镜像名
IMAGE_FULL_NAME=wangduanduan/opensips:$(OPENSIPS_VERSION)

# 额外需要构建的模块
BUILD_MOD=db_mysql

OCI=podman

build:
	$(OCI) build \
		--build-arg=OPENSIPS_VERSION=$(OPENSIPS_VERSION) \
		--build-arg=BUILD_MOD=$(BUILD_MOD) \
		--progress=plain \
		--tag="$(IMAGE_FULL_NAME)" \
		.

run:
	-$(OCI) rm -f ops
	$(OCI) run -d --name ops \
	-v $$PWD/opensips:/usr/local/etc/opensips \
	-v $$PWD/log:/var/log \
	$(IMAGE_FULL_NAME) -m 1024 -M 64

exec:
	docker exec -it ops bash
