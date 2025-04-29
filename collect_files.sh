#!/bin/bash

# Функция для копирования файлов
copy_files() {
    local cur_dir="$1"

    for item in "$cur_dir"/*; do
        if [ -f "$item" ]; then
            filename=$(basename "$item")
            name="${filename%.*}"
            ext="${filename##*.}"
            
            if [ "$name" = "$filename" ]; then
                ext=""
            else
                ext=".$ext"
            fi

            new_name="${name}${ext}"
            counter=1
            
            while [ -e "$output_dir/$new_name" ]; do
                new_name="${name}_${counter}${ext}"
                counter=$((counter + 1))
            done

            cp "$item" "$output_dir/$new_name"
        elif [ -d "$item" ]; then
            copy_files "$item"
        fi
    done
}

# Основная логика скрипта
if [ $# -eq 2 ]; then
    input_dir="$1"
    output_dir="$2"
    
    # Создаем выходную директорию, если её нет
    mkdir -p "$output_dir"
    
    # Запускаем копирование
    copy_files "$input_dir"
else
    echo "Usage: $0 input_dir output_dir"
    exit 1
fi
