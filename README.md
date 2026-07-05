# Argo-Pro

Argo-Pro 是一个 Argo / Xray / VLESS PQC / Reality / XHTTP / HTTPUpgrade 自动化部署项目。

## 推荐部署方式

不要直接执行大型 `argox.sh` 的 Raw 链接。推荐执行小型启动器 `install.sh`：

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hkzping999/Argo-Pro/main/install.sh)
```

或：

```bash
bash <(wget -qO- https://raw.githubusercontent.com/hkzping999/Argo-Pro/main/install.sh)
```

`install.sh` 会：

1. 下载整个 GitHub 仓库源码包；
2. 自动把 `.sh/.conf/.md/.txt/.json/.yml` 等文本文件转换成 Unix LF；
3. 对 `argox.sh` 执行 `bash -n` 语法检查；
4. 检查通过后运行 `argox.sh`。

这样可以避免大脚本 Raw 换行格式异常导致的一键部署失败。

## 传统部署方式

如果你的仓库 Raw 已确认是标准 LF，也可以执行：

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hkzping999/Argo-Pro/main/argox.sh)
```

但更推荐使用 `install.sh`。

## 本地自检

```bash
bash -n install.sh
bash -n argox.sh
bash -n argox-next.sh
./argox-next.sh --test-modules
./argox-next.sh --list-protocols
./argox-next.sh --build-sample > /tmp/argo-pro-inbound.sample.json
```

## 上传到 GitHub

不要复制粘贴 `argox.sh` 内容。请解压本项目包后直接上传文件，或用 Git 命令推送整个目录。

```bash
git init
git config core.autocrlf false
git config core.eol lf
git add .
git commit -m "Upload Argo-Pro latest deployable package"
git branch -M main
git remote add origin https://github.com/hkzping999/Argo-Pro.git
git push --force origin main
```

更多上传说明见 `UPLOAD_TO_GITHUB.md`。
