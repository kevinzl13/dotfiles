#!/bin/bash

confirm() {
  confirm_options=("" "✖")
  confirm_choice=$(printf "%s\n" "${confirm_options[@]}" | rofi -dmenu -p "¿Estás seguro?" -theme "~/.config/rofi/themes/powermenu/confirm.rasi")

  if [[ "$confirm_choice" == "" ]]; then
    echo "Acción confirmada"
    return 0
  else
    echo "Acción cancelada"
    return 1
  fi
}

confirm
