#!/usr/bin/env bash

export NEWT_COLORS='
root=brightcyan,black
roottext=brightcyan,black
window=white,black
border=brightcyan,black
title=brightcyan,black
textbox=white,black
button=black,brightcyan
actbutton=black,brightmagenta
compactbutton=brightcyan,black
checkbox=brightcyan,black
actcheckbox=black,brightcyan
entry=white,black
label=brightcyan,black
listbox=white,black
actlistbox=black,brightcyan
sellistbox=black,brightmagenta
actsellistbox=black,brightmagenta
helpline=brightcyan,black
emptyscale=brightcyan,black
fullscale=black,brightcyan
disentry=gray,black
'

kitty \
  --class network-tui \
  --title network-tui \
  --override background=#080a12 \
  --override foreground=#d7e1ff \
  --override background_opacity=0.94 \
  --override cursor=#00e5ff \
  --override selection_background=#00e5ff \
  --override selection_foreground=#080a12 \
  --override font_size=16 \
  --override window_padding_width=14 \
  nmtui &

sleep 0.2
hyprctl dispatch focuswindow "class:^(network-tui)$"
