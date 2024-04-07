#!/bin/bash

echo "Build started"

input_file="main.sh"
output_file="setup.sh"

# Clear the output file
> "$output_file"

# Replace the line "source $sh_file_path" with the content of the file
while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" =~ ^[[:space:]]*source[[:space:]]+(.*) ]]; then
        source_filename="${BASH_REMATCH[1]}"
        echo "# region $source_filename" >> "$output_file"
        cat "$source_filename" >> "$output_file"
        echo "# endregion $source_filename" >> "$output_file"
        echo >> "$output_file"
    else
        echo "$line" >> "$output_file"
    fi
done < "$input_file"

echo "Build completed"
