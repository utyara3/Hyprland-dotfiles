#!/bin/sh

WALLPAPERS_DIR="$HOME/.config/hypr/images"
INDEX_FILE="$HOME/.config/hypr/current_wallpaper_index"

# Получаем отсортированный список обоев
WALLPAPERS=$(find "$WALLPAPERS_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)
WALLPAPER_COUNT=$(echo "$WALLPAPERS" | wc -l)

if [ "$WALLPAPER_COUNT" -eq 0 ]; then
    echo "No wallpapers found in $WALLPAPERS_DIR" >&2
    exit 1
fi

# Читаем текущий индекс или начинаем с 0
if [ -f "$INDEX_FILE" ]; then
    CURRENT_INDEX=$(cat "$INDEX_FILE")
    # Проверяем, что индекс в допустимых пределах
    if [ "$CURRENT_INDEX" -lt 0 ] || [ "$CURRENT_INDEX" -ge "$WALLPAPER_COUNT" ]; then
        CURRENT_INDEX=0
    fi
else
    CURRENT_INDEX=0
fi

# Выбираем обои по текущему индексу
SELECTED=$(echo "$WALLPAPERS" | sed -n "$((CURRENT_INDEX + 1))p")

# Увеличиваем индекс для следующего запуска (сбрасываем в 0 если достигли конца)
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % WALLPAPER_COUNT ))
echo "$NEXT_INDEX" > "$INDEX_FILE"

# Устанавливаем обои
swww img "$SELECTED" --transition-type wipe --transition-step 90 --transition-duration 0.7
