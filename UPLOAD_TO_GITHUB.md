# 上传到 GitHub 的最稳方式

不要把 `argox.sh` 的 5000 多行内容复制粘贴到 GitHub 网页编辑器里。
请直接上传文件，或者用 Git 命令推送整个目录。

## 方式 A：GitHub 网页上传整个目录

1. 解压本包。
2. 打开你的仓库，例如：`https://github.com/hkzping999/Argo-Pro`。
3. 点击 **Add file -> Upload files**。
4. 把解压后的所有文件和目录拖进去。
5. Commit changes。

## 方式 B：Git 命令推送

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

## 推荐一键部署命令

推荐执行小型 bootstrap：

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hkzping999/Argo-Pro/main/install.sh)
```

或：

```bash
bash <(wget -qO- https://raw.githubusercontent.com/hkzping999/Argo-Pro/main/install.sh)
```

`install.sh` 会下载整个仓库、自动转换换行为 Unix LF、检查 `argox.sh` 语法，然后再运行主脚本。

## 上传后检查

```bash
curl -fsSL https://raw.githubusercontent.com/hkzping999/Argo-Pro/main/install.sh -o /tmp/install.sh
bash -n /tmp/install.sh

curl -fsSL https://raw.githubusercontent.com/hkzping999/Argo-Pro/main/argox.sh | python3 -c 'import sys; b=sys.stdin.buffer.read(); print("LF", b.count(b"\n"), "CR", b.count(b"\r"))'
```
