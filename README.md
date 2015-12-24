# aliyun-oss-sync

阿里云OSS同步工具

## 安装

    gem install aliyun-oss-sync

## 同步

### 本地文件同步到OSS

    OSS_ACCESS_ID=your-access-id \
    OSS_ACCESS_SECRET=your-access-secret \
    aliyun-oss-sync -e endpoint push bucket名称:远程目录 本地目录

### OSS文件同步到本地(Not implemented)

    OSS_ACCESS_ID=your-access-id \
    OSS_ACCESS_SECRET=your-access-secret \
    aliyun-oss-sync -e endpoint  pull bucket名称:远程目录 本地目录

### Example

    aliyun-oss-sync -e http://oss-cn-shenzhen.aliyuncs.com -k xxx -s ooo push mybucket:remote_path local_path

### 参数

~~~sh
NAME
    aliyun-oss-sync - aliyun oss sync

SYNOPSIS
    aliyun-oss-sync [global options] command [command options] [arguments...]

VERSION
    0.0.1

GLOBAL OPTIONS
    -e, --endpoint=arg - aliyun access endpoint (default: none)
    --help           - Show this message
    -k, --key=arg    - aliyun access key id (default: none)
    -s, --secret=arg - aliyun access key secret (default: none)
    --version        - Display the program version

COMMANDS
    help - Shows a list of commands or help for one command
    pull - pull files from Aliyun OSS to local directory
    push - push files from local directory to Aliyun OSS
    sync - sync files between local directory and Aliyun OSS
~~~


