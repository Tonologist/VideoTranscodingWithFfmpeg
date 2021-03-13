#!/bin/bash
depth=0 # 用于标记目录的深度
# 用来打印出缩进前面用的竖线
PRINT_PREFIX(){
  n_of_space=`expr $1 + 1`
  for j in $(seq 1 $n_of_space)
  do
    printf "| "
  done
}
# 递归用的函数
CYCLING(){
  spath=`pwd`
  filelist=`ls | tr " " "_"`
  for filename in $filelist
  do
    f="`echo ${filename} | tr " " "_"`"
    f1="`echo ${filename}| sed 's/_/ /g'`"
#    echo "f: $f"
#    echo "f1: $f1"
    if [ "$f" != "$f1" ]
    then
      echo "do rename."
      mv "$f1" "$f" #重命名
    fi
#    sleep 1
    if test -f $f  # 检查是否是文件
    then
      PRINT_PREFIX $depth
      printf "\033[0m$f \033[0m\n" # 是文件正常显示
    else
      PRINT_PREFIX $depth
      printf "\033[1m$f \033[0m\n" # 是目录加粗显示
      cd $f
      depth=`expr $depth + 1`
      CYCLING # 递归
      cd ..
      depth=`expr $depth - 1`
    fi
#   sleep 3
  done
}

echo "Current directory:"
CYCLING

