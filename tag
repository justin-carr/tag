#!/bin/bash

tag_name="$1"
tag_dir="$HOME/.local/share/sha256tags/$tag_name"

if [ ! -d "$tag_dir" ]; then
    mkdir -p "$tag_dir"
fi

shift
if [ "$1" = "-l" ]; then
    find "$tag_dir" -type l -printf "%l\n"
    exit 0
fi

while [ $# -gt 0 ]; do
    case "$1" in
        -r)
            remove_tag="true"
            shift
            ;;
        *)
            file="$1"
            file_path="$(realpath "$file")"
            file_hash=$(sha256sum "$file_path" | cut -d ' ' -f 1)
            linked_file="$tag_dir/${file_hash}"

            if [ -n "$remove_tag" ]; then
                if [ -L "$linked_file" ]; then # Remove tag
                    rm "$linked_file"

                    if [ ! -e "$tag_dir"/* ]; then # Remove tag directory if empty
                        rmdir "$tag_dir"
		    fi
                else
			if [ ! -d "$tag_dir" ]; then
				echo "${tag_name} tag does not exist."
			else
				echo "${file_path} not tagged \"${tag_name}\"."
			fi
                fi
            else
		ln -s "$file_path" "$linked_file" # Add tag
            fi
            
            shift
            ;;
    esac
done
