# QDU Daily Report
一个用于自动填报体温统计的脚本，使用 Shell Script 编写。
# Requirements
- jq
- curl
- gawk
- md5sum
- base64   
自行安装。
# Usage
## 配置
将 `config.json.template` 文件复制到 `config.json`，并修改配置文件。
## 使用
执行 `bash main.sh` 命令。即可开始填报。
## 部署至 Docker
使用
```bash
$ docker-compose up -d
```
即可启动一个 Docker 容器。可以自助修改`Containerfile`设置填报时间。
## 使用 cron
执行 `crontab -e`, 编辑 `crontab`文件，添加以下内容：
```bash
5 8-19/1 * * * bash /daily_report/main.sh
```
# Thanks
Refer [jj4/antlinkercampus](https://github.com/jj4/antlinkercampus).
