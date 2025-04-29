#!/bin/bash

copy_files() {
    local cur_dir="$1"

    for item in "$cur_dir"/*; do
        if [ -f "$item" ]; then
            filename=$(basename "$item")
            name="${filename%.*}"
            ext="${filename##*.}"

            new_filename="${name}.${ext}"
            count=1
            
            while [ -e "$output_dir/$new_filename" ]; do
                new_filename="${name}_${count}${ext}"
                count=$((count + 1))
            done

            cp "$item" "$output_dir/$new_filename"
        elif [ -d "$item" ]; then
            copy_files "$item"
        fi
    done
}

if [ $# -eq 2 ]; then
    input_dir="$1"
    output_dir="$2"
    
    copy_files "$input_dir"
fi
