# Git for Windows 汉化

## 用法

在 WSL 或 git bash 中

```bash
# ./build.sh <Git for windows 版本号>
./build.sh 2.31.0.windows.1
```

生成 `build-2.31.0.windows.1.zip`，把里面的东西解压到 Git 安装目录即可汉化。

如果获取不了源码，就把 `build.sh` 里的下载地址行头的井号 `#` 换一下位置

``` bash
curl -L -O "https://github.com/git-for-windows/git/archive/refs/tags/$tarfile"
# curl -L -O "https://hub.fastgit.org/git-for-windows/git/archive/refs/tags/$tarfile"
```

改为

``` bash
# curl -L -O "https://github.com/git-for-windows/git/archive/refs/tags/$tarfile"
curl -L -O "https://hub.fastgit.org/git-for-windows/git/archive/refs/tags/$tarfile"
```

## 移除汉化

去 Git 安装目录中删除这三个文件

```
/mingw64/share/locale/zh_CN/LC_MESSAGES/git.mo
/mingw64/share/git-gui/lib/msgs/zh_cn.msg
/mingw64/share/gitk/lib/msgs/zh_cn.msg
```
