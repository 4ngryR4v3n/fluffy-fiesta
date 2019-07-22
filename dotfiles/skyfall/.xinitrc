[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

exec sxhkd &
exec bspwm
