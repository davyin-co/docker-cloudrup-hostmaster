# 介绍
站群系统使用的webserver的docker镜像，基于ubuntu 18.04,安装配置了apache/php/ssh等。

# docker-compose example for cloudrup hostmaster
cloudrup.make content:
```
core = 7.x
api = 2

projects[drupal][type] = core
projects[drupal][version] = 7.82

; RELEASE
; Leave in place for replacement by release process.
projects[devmaster][type] = profile
projects[devmaster][download][type] = git
projects[devmaster][download][branch] = cloudrup
projects[devmaster][download][url] = https://github.com/ipumpkin/devmaster.git
```

docker-compose.yml content
```bash
version: '3'
services:
  hostmaster:
    image: davyinsa/cloudrup-hostmaster:7.3
    restart: always
    privileged: true
    hostname: cloudrup
    container_name: cloudrup
    volumes:
      - ~/www/cloudrup/aegir:/var/aegir
      - ./cloudrup.make:/tmp/custom.make
    environment:
      VIRTUAL_HOST: cloudrup.docker
      HOSTNAME: cloudrup.docker
      AEGIR_MAKEFILE: /tmp/custom.make
      #AEGIR_MAKEFILE: https://github.com/opendevshop/devshop/blob/1.x/build-devmaster.make
      MYSQL_ROOT_PASSWORD: password
      AEGIR_DATABASE_SERVER: mysql
      AEGIR_HOSTMASTER_ROOT: /var/aegir/cloudrup
      AEGIR_ROOT: /var/aegir
      AEGIR_PROFILE: devmaster
networks:
  default:
    external:
      name: proxy
```

# 环境变量支持
#### apache & php
|Name|Desciption|
|----|----------|
|PHP_MEM_LIMIT|The php memory limit in php.ini. default value is 128M.|
|PHP_MAX_EXECUTION_TIME|php max_execution_time|
|PHP_UPLOAD_SIZE|php post_max_size and upload_max_filesize|
|PHP_MAX_INPUT_VARS|php max_input_vars|
|PHP_DISPLAY_ERRORS|php display_errors and display_startup_errors|
