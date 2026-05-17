1. Magit起動

C-x g

2.ファイルをステージに

該当ファイルにカーソルを置いてs。展開されていなければTAB
git add init.el

3. commit

c cでコメントを書く。
C-c C-cで決定。
git commit -m "Add sanitized init.el"

4. branch名を の変更する

b rを連続で押して、ブランチ名を変更
main
git branch -M main
M-x magit-branch-rename

5.remoteを追加 

M a
Remote name: origin
https://github.com/count-three/my.emacs.git

git remote add origin https://github.com/count-three/my.emacs.git

6. push

P p
