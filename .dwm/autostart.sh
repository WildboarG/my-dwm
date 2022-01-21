#/bin/bash

/bin/bash ~/.dwm/dwm_refresh.sh &

#fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx &

picom &

nitrogen --restore &

kde &

libinput-gestures-setup start &

/bin/bash ~/.dwm/autostart_wait.sh &

