#!/bin/bash

copy_files() {
    local cur_dir="$1"

    for item in "$cur_dir"/*; do
        if[ -f "$item" ]; then
            filename=$(basename "$item")
            name="${filename%.*}"
            ext="${filename##*.}"
            if["$name" = "$filename"]; then
                ext=""
            else
                ext=".$ext"
            fi

            new_filename="${name}${ext}"
            count=1
            while [-e "$output_dir/$new_name"]; do
                new_name="${name}_${counter}${ext}"
                count=$((count+1))
            done

            cp "$item" "$output_dir/$new_name"
        elif [-d "$item"];  then
            copy_files "$item"
        fi
    done
}

if [ $# -eq 2 ]; then
    input_dir="$1"
    output_dir="$2"

    copy_files "input_dir"
else
    input_dir="$1"
    output_dir="$2"
    max_depth="$4"
fi

