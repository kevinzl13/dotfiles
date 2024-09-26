#!/bin/bash

# Definir íconos y acciones
shutdown=""
reboot=""
suspend_system="󰽥"
lock_screen=""
logout_system="󰍃"
cancel=""

options=(
  "$shutdown"
  "$reboot"
  "$suspend_system"
  "$lock_screen"
  "$logout_system"
  "$cancel"
)

confirm() {
  confirm_options=("" "✖")
  confirm_choice=$(printf "%s\n" "${confirm_options[@]}" | rofi -dmenu -p "¿Estás seguro?" -theme "~/.config/rofi/themes/powermenu/confirm.rasi")

  if [[ "$confirm_choice" == "" ]]; then
    return 0
  else
    return 1
  fi
}


# Mostrar menú con rofi
choice=$(printf "%s\n" "${options[@]}" | rofi -dmenu -p "Seleccione una acción" -theme "~/.config/rofi/themes/powermenu/power_menu.rasi")

# Tomar acción según la elección
case "$choice" in
  "$shutdown") 
    if confirm; then
      systemctl poweroff
    fi
    ;;
  "$reboot")
    if confirm; then
      systemctl reboot
    fi
    ;;
  "$suspend_system")
    if confirm; then
      systemctl suspend
    fi
    ;;
  "$lock_screen")
    if confirm; then
      if [[ $XDG_CURRENT_DESKTOP == "X-Cinnamon" ]]; then 
        cinnamon-screensaver-command --lock
      elif [[ $XDG_CURRENT_DESKTOP == "i3" ]]; then
        i3lock
      elif [[ $XDG_CURRENT_DESKTOP == "X-Qtile" ]]; then
        i3lock
      else
        echo "Entorno desconocido"
      fi
    fi
    ;;
  "$logout_system")
    if confirm; then
      if [[ "$XDG_CURRENT_DESKTOP" == "X-Cinnamon" ]]; then
        cinnamon-session-quit --logout
      elif [[ "$XDG_CURRENT_DESKTOP" == "i3" ]]; then
        i3-msg exit
      elif [[ "$XDG_CURRENT_DESKTOP" == "X-Qtile" ]]; then
        qtile cmd-logout
      fi
    fi
    ;;
  "$cancel")
    exit 0
    ;;
  *)
    exit 1
    ;;
esac
