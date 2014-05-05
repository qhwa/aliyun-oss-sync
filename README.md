# aliyun-oss-sync

阿里云OSS同步工具

## 安装

    gem install aliyun-oss-sync

## 同步

### 本地文件同步到OSS

    OSS_ACCESS_ID=your-access-id \
    OSS_ACCESS_SECRET=your-access-secret \
    aliyun-oss-sync push bucket名称:远程目录 本地目录

### OSS文件同步到本地

    OSS_ACCESS_ID=your-access-id \
    OSS_ACCESS_SECRET=your-access-secret \
    aliyun-oss-sync pull bucket名称:远程目录 本地目录

具体的参数可以用 `aliyun-oss-sync --help [子命令]` 查看


