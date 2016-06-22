#!/bin/bash

### FUNCTIONS ###

ShowAllFiles(){
  printf "全てのファイルを表示しますか？(はい:1 いいえ:0)"
  while :
  do
    read ans
    case ${ans} in
      1)defaults write com.apple.finder AppleShowAllFiles YES
        break;;
      0)defaults write com.apple.finder AppleShowAllFiles NO
        break;;
      *)printf "1か0を入力してください。もしくはCtrl+Cで中断してください。";;
    esac
  done
}

CreateDesktop(){
  printf "デスクトップを表示しますか？(はい:1 いいえ:0)"
  while :
  do
    read ans
    case ${ans} in
      1)defaults write com.apple.finder CreateDesktop -bool true
        break;;
      0)defaults write com.apple.finder CreateDesktop -bool false
        break;;
      *)printf "1か0を入力してください。もしくはCtrl+Cで中断してください。";;
    esac
  done
  
}

SpacerLeft(){
  printf "左サイドにスペーサーを挿入する数を入力してください。(0-9)"
  while :
  do
    read ans
    case ${ans} in
      [0-9])while [ ${ans} -gt 0 ]; do
              defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
              ans=$(( ans - 1 ))
            done
            break;;
      *)printf "0から9までの整数を入力してください。もしくはCtrl+Cで中断してください。";;
    esac
  done
}

SpacerRight(){
  printf "右サイドにスペーサーを挿入する数を入力してください。(0-9)"
  while :
  do
    read ans
    case ${ans} in
      [0-9])while [ ${ans} -gt 0 ]; do
              defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'
              ans=$(( ans - 1 ))
            done
            break;;
      *)printf "0から9までの整数を入力してください。もしくはCtrl+Cで中断してください。";;
    esac
  done
}

RecentsFolder(){
  printf "最近使ったフォルダを挿入する数を入力してください。(0-9)"
  while :
  do
    read ans
    case ${ans} in
      [0-9])while [ ${ans} -gt 0 ]; do
              defaults write com.apple.dock persistent-others -array-add '{"tile-data" = {"list-type" = 1;}; "tile-type" = "recents-tile";}'
              ans=$(( ans - 1 ))
            done
            break;;
      *)printf "0から9までの整数を入力してください。もしくはCtrl+Cで中断してください。";;
    esac
  done
}

ScreenshotFolder(){
  printf "スクリーンショットの保存場所のパスを入力してください。（「Pictures/Screenshots」など。）\n~/"
  read path
  if [ ! -d "${path}" ]; then
    mkdir -p ${path}
    printf "「~/${path}」を作成…"
  fi
  defaults write com.apple.screencapture location ~/${path}
}

### END FUNCTIONS ###


printf "\nシステム環境設定でアクセスできない設定の内、個人的によく使うものをまとめました。\n\n"
printf "以下の設定が実行できます。\n\n"
printf "【ファインダー設定】\n"
printf "1) 全てのファイルの表示\n"
printf "2) デスクトップの削除\n\n"
printf "【ドック設定】\n"
printf "3) 左サイドにスペーサーを挿入\n"
printf "4) 右サイドにスペーサーを挿入\n"
printf "5) 最近使った項目を挿入\n\n"
printf "【システム設定】\n"
printf "6) スクリーンショットの保存場所の変更\n\n"
printf "行う設定を選択してください。（整数1-6、全て実行する場合は0。中断は^C）\n"

while :
do
read answer

case ${answer} in
0)
  ShowAllFiles
  CreateDesktop
  SpacerLeft
  SpacerRight
  RecentsFolder
  ScreenshotFolder

  killall Finder
  killall Dock
  killall SystemUIServer
break;;

1)
  ShowAllFiles
  killall Finder
break;;
2)
  CreateDesktop
  killall Finder
break;;
3)
  SpacerLeft
  killall Dock
break;;
4)
  SpacerRight
  killall Dock
break;;
5)
  RecentsFolder
  killall Dock
break;;
6)
  ScreenshotFolder
  killall SystemUIServer
break;;

*)printf "整数1-6を選択してください。全て実行する場合は0、中断はCtrl+Cです。";;
esac

done
printf "\n処理が完了しました。\n©2016 Taro Yoshioka\n"
exit 0