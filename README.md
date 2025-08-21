# Home Assistant FRPC Add-On

## 概述
这是一个用于 Home Assistant 的 FRPC (FRP Client) 加载项。它支持多平台（包括 amd64, aarch64, armv7, armhf, i386），可以连接多个端口。该加载项通过 FRP 客户端连接远程服务器，能够为 Home Assistant 提供内网穿透服务。

该项目的版本号采用 `年月日+序号` 的方式进行管理，例如 `20250821.1`。

## 功能特性
- 支持多平台安装：amd64, aarch64, armv7, armhf, i386。
- 支持多个端口配置。
- 使用 GitHub Actions 自动构建和发布多架构 Docker 镜像。
- 可以方便地与 Home Assistant 系统集成。
- 支持高效的内网穿透，确保远程访问。

## 安装指南

### 1. 下载 Home Assistant 加载项
在 Home Assistant 的 UI 中，进入“Supervisor”界面，点击“添加加载项”，然后点击“上传自定义加载项”，选择本项目的 `.tar` 文件。

### 2. 安装加载项
下载并上传加载项后，点击“安装”，系统会自动下载所需的依赖项并开始安装。

### 3. 启动加载项
安装完成后，点击“启动”按钮即可启动 FRPC 客户端。

### 4. 配置加载项

打开 Home Assistant 的配置界面，找到 FRPC 加载项的配置页面。你需要根据实际情况设置连接的远程服务器和端口。

示例配置：
```yaml
frpc:
  server: "your.frp.server"
  server_port: 7000
  token: "your-frp-token"
  ports:
    - local_port: 8080
      remote_port: 80
    - local_port: 5000
      remote_port: 5000
```

#### 配置说明：
- `server`: FRP 服务器的地址。
- `server_port`: FRP 服务器的端口，通常是 7000。
- `token`: FRP 服务器的鉴权 token，需确保和 FRP 服务器配置一致。
- `ports`: 配置本地端口和远程端口的映射。可以支持多个端口。

### 5. 启动并监控 FRPC

启动后，可以通过 Home Assistant 的日志界面查看 FRPC 客户端的运行状态，确保一切正常。

## GitHub Actions 构建与发布

该项目使用 GitHub Actions 进行自动构建，并将构建好的镜像推送到 GitHub 容器注册表 (GHCR)。确保可以为不同架构的设备自动生成镜像，并推送到 Home Assistant 的加速下载源。

### 示例 GitHub Actions 配置
```yaml
name: Build and Publish FRPC Add-On

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Build Docker image
        run: |
          docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7,linux/386 -t ghcr.io/sunboss/homeassistant-frpc:$(date +'%Y%m%d').1 .

      - name: Push to GHCR
        run: |
          docker push ghcr.io/sunboss/homeassistant-frpc:$(date +'%Y%m%d').1
```

### 版本号格式
版本号的格式为 `YYYYMMDD.x`，例如 `20250821.1`，其中：
- `YYYYMMDD`：表示发布的日期。
- `x`：表示当天的版本序号。

## 问题和反馈

如果在使用过程中遇到任何问题或有建议，欢迎通过 [GitHub Issues](https://github.com/sunboss/homeassistant-frpc/issues) 提交反馈。

## 贡献

欢迎提交 PR 来贡献代码，或者报告问题和请求功能改进。

## 许可证

本项目遵循 [MIT 许可证](https://opensource.org/licenses/MIT)。