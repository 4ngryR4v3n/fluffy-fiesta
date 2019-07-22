# Skyfall

## Description

This configuration for Arch Linux is based on the [skyfall](https://github.com/elenapan/dotfiles/blob/master/.xfiles/skyfall) color scheme.

## Contents

- [Dependencies](#dependencies)
- [Installation](#installation)

## Dependencies

Install the following dependencies.

`sudo pacman -S bspwm dmenu feh hsetroot light rxvt-unicode sxhkd xorg-server xorg-xinit`

`yay -S polybar`

- [bspwm](https://github.com/baskerville/bspwm)
- [dmenu](https://wiki.archlinux.org/index.php/dmenu)
- [feh](https://wiki.archlinux.org/index.php/feh)
- [hsetroot](https://github.com/himdel/hsetroot)
- [light](https://github.com/haikarainen/light)
- [polybar](https://github.com/polybar/polybar)
- [rxvt-unicode](https://wiki.archlinux.org/index.php/Rxvt-unicode)
- [sxhkd](https://github.com/baskerville/sxhkd)
- [xorg-server](https://www.archlinux.org/packages/extra/x86_64/xorg-server/)
- [xorg-xinit](https://www.archlinux.org/packages/extra/x86_64/xorg-xinit/)

## Installation

`git clone https://github.com/Perdyx/fluffy-fiesta.git`

`cp -r fluffy-fiesta/dotfiles/skyfall/polybar/ ~/.config/`

`cp -r fluffy-fiesta/dotfiles/skyfall/bspwm/ ~/.config/`

`cp -r fluffy-fiesta/dotfiles/skyfall/sxhkd/ ~/.config/`

`cp fluffy-fiesta/dotfiles/skyfall/.xinitrc ~/`

`cp fluffy-fiesta/dotfiles/skyfall/.Xresources ~/`
