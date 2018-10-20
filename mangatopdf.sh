#!/bin/bash
loop=0
retry=0
cont=1
read -er -p "Insert the manga url here: " url
manganame=$(echo $url | awk -F '/' '{print $6}')
chapter=$(echo $url | awk -F '/' '{print $7}')
mkdir $manganame
cd $manganame
mkdir $chapter
cd $chapter
while [ $loop -lt 1 ]; do
 if [ $retry = 2 ]; then
  loop=1
 else
  if [ $cont -lt 10 ]; then
  wget $url$cont.jpg -O $manganame'0'$cont.jpg
  check=$(ls -s | grep $manganame'0'$cont".jpg" | awk '{print $1}')
  else
  wget $url$cont.jpg -O $manganame$cont.jpg
  check=$(ls -s | grep $manganame$cont".jpg" | awk '{print $1}')
  fi
  if [ $check = 0 ]; then
   let retry=retry+1
   rm $manganame$cont".jpg"
  else
   let cont=cont+1
  fi
 fi
done
convert * $chapter.pdf
