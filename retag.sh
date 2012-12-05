#!/bin/sh
echo "tagをつけるbranchで実行してください。"
echo "対象のbranchをgit pullで最新にして下さい。"
echo "よろしいですか？(y/n)"
read CONFIRM
if ! [ $CONFIRM = "y" ]
then
  exit 0
fi

echo "tag名を入力して下さい(例:v1.3.0)"
git tag
read TAG_NAME

echo "branch名を入力して下さい(例:hotfix-1.3.x)"
git branch
read BRANCH_NAME
echo "========================================="
echo "tag名は $TAG_NAME です"
echo "branch名は $BRANCH_NAME です"
echo "ほんとにやりますよ？よろしいですか？(y/n)"
read CONFIRM
if ! [ $CONFIRM = "y" ]
then
  exit 0
fi

# 最新のtagを取得
git pull origin --tags

# tagを削除
git tag -d $TAG_NAME

# githubのtagを削除
git push origin :$TAG_NAME

# yamasaのtagを削除
git push yamasa :$TAG_NAME

# 新しいタグをつける
git tag -a $TAG_NAME -m "release $TAG_NAME"

#pushする
git push origin $BRANCH_NAME --tags
git push yamasa $BRANCH_NAME --tags
