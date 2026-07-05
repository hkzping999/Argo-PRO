# Argo-Pro

Argo-Pro  Argo / Xray / VLESS PQC / Reality / XHTTP / HTTPUpgrade 

## 推荐部署方式

推荐执行小型启动器 `install.sh`：

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


更多上传说明见 `UPLOAD_TO_GITHUB.md`。
