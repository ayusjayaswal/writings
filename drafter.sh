#!/bin/bash
echo "Draft a new manuscript :D"
echo -n "filename => "
read file
[[ "$file" != *.md ]] && file="${file}.md"
touch "$file"
echo -n "title= "
read title
date=$(date +%Y-%M-%d)

{
	echo "+++"
	echo "title = \"$title\""
	echo "date = \"$date\""
	echo "[taxonomies]"
	echo "tags = []"
	echo "+++"
} >> "$file"

nvim $file
