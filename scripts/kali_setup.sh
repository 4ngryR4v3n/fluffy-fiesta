#!/bin/bash

set -euo pipefail

`apt-get install dconf-editor`

`gsettings set org.gnome.desktop.interface clock-format "12h"`
`gsettings set org.gnome.desktop.calendar show-weekdate "true"`

`gsettings set org.gnome.peripherals.touchpad tap-to-click "true"`

`gnome-shell-extension-tool -e alternate-tab@gnome-shell-extensions.gcampax.github.com`
`gnome-shell-extension-tool -e caffeine@patapon.info`
`gnome-shell-extension-tool -d desktop-icons@csoriano`
`gnome-shell-extension-tool -e disconnect-wifi@kgshank.net`
`gnome-shell-extension-tool -d EasyScreenCast@iacopodeenosee.gmail.com`
`gnome-shell-extension-tool -e impatience@gfxmonk.net`
`gnome-shell-extension-tool -e drive-menu@gnome-shell-extensions.gcampax.github.com`

`gsettings set org.gnome.shell.extensions.dash-to-dock require-pressure-to-show "false"`
`gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode "ALL_WINDOWS"`
`gsettings set org.gnome.shell.extensions.dash-to-dock animate-show-apps "false"`
`gsettings set org.gnome.shell.extensions.dash-to-dock click-action "minimize"`
`gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action "switch-workspace"`
`gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink "false"`
`gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode "FIXED"`
`gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity "0"`
