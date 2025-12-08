#!/bin/bash
directory=$1
archive_name=$(basename "$directory")
dir_name="${archive_name%.tgz}"
scratch_dir=$(mktemp -d scratch.XXXXXX)
clean=cleaned_$archive_name

# Extract the archive into the temporary directory
tar -xzf "$directory" -C "$scratch_dir"

# Find and delete files containing the line "DELETE ME!"
cd "$scratch_dir/$dir_name" || exit 1
grep -rl "DELETE ME!" . | xargs rm -f
cd ..
tar -czf "../../$clean" "$dir_name"
# in the current directory containing the cleaned contents of the original
# archive, with the name `cleaned_<original-archive-name>.tgz`.
cd ../..
# Clean up the temporary directory
rm -rf "$scratch_dir"
# If this test fails, you probably didn't name the cleaned archive correctly.