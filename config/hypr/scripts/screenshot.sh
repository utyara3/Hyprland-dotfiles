#!/bin/bash
MODE=$1
CLIPBOARD=$2
FOLDER="$HOME/Изображения/HyprShots/"

mkdir -p "$FOLDER"

case "$MODE" in
    "output")
        AREA="screen"
        ;;
    "window")
        AREA="active"
        ;;
    "region")
        AREA="area"
        ;;
    *)
        AREA="screen"
        ;;
esac

if [ "$CLIPBOARD" = "clipboard" ]; then
    if grimblast copy "$AREA"; then
        notify-send -t 2000 "📸 Скриншот" "Скопировано в буфер ($MODE)"
    else
        notify-send -t 3000 "❌ Ошибка" "Не удалось сделать скриншот"
    fi
else
    FILENAME="$FOLDER/$(date +'%Y-%m-%d_%H-%M-%S').png"
    
    if grimblast save "$AREA" "$FILENAME"; then
        notify-send -t 2000 "📸 Скриншот" "Сохранено:\n$(basename "$FILENAME")"
    else
        notify-send -t 3000 "❌ Ошибка" "Не удалось сохранить скриншот"
    fi
fi
