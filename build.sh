#!/bin/bash

if [ "x$1" == "x" ]; then
  echo "Missing git version"
  exit 1
fi

gitver="$1"
tarfile="v$gitver.tar.gz"

if [ ! -f "$tarfile" ]; then
  curl -L -O "https://github.com/git-for-windows/git/archive/refs/tags/$tarfile"
  # curl -L -O "https://hub.fastgit.org/git-for-windows/git/archive/refs/tags/$tarfile"
fi

tar xf "$tarfile"

dir="git-$gitver"

outdir="build"

modir="$outdir/mingw64/share/locale/zh_CN/LC_MESSAGES"
guidir="$outdir/mingw64/share/git-gui/lib/msgs"
gitkdir="$outdir/mingw64/share/gitk/lib/msgs"

mkdir -p $modir
mkdir -p $guidir
mkdir -p $gitkdir
msgfmt -o "$modir/git.mo" ./$dir/po/zh_CN.po
msgfmt --tcl -l zh_CN -d "$guidir" ./$dir/git-gui/po/zh_cn.po
msgfmt --tcl -l zh_CN -d "$gitkdir" ./$dir/gitk-git/po/zh_cn.po

zipname="build-$gitver.zip"

if [ -d "$outdir" ]; then
  rm -rf "$zipname"
  
  type zip >/dev/null 2>&1
  if [ "x$?" == "x0" ]; then
    cd "$outdir"
    zip -r -y "../$zipname" .
    cd ..
  else
    powershell.exe -nologo -noprofile -command \
      '& { param([String]$sourceDirectoryName, [String]$destinationArchiveFileName, [Boolean]$includeBaseDirectory); Add-Type -A "System.IO.Compression.FileSystem"; Add-Type -A "System.Text.Encoding"; [IO.Compression.ZipFile]::CreateFromDirectory($sourceDirectoryName, $destinationArchiveFileName, [IO.Compression.CompressionLevel]::Fastest, $includeBaseDirectory, [System.Text.Encoding]::UTF8); exit !$?;}' \
      -sourceDirectoryName "\"$outdir\"" \
      -destinationArchiveFileName "$zipname" \
      -includeBaseDirectory '$false'
    if [ $? -ne 0 ]; then
      echo "Zip failed"
      exit $?
    fi
  fi
fi

rm -rf "$outdir"
rm -rf "$dir"
# rm -rf "$tarfile"
