#!/bin/bash
directory=$1
archive_name=$(basename "$directory").tgz
scratch_dir=$(mktemp -directory scratch.XXXXXX)
clean=cleaned_$(basename "$directory").tgz

# Extract the archive into the temporary directory
tar -xzf "$directory.tgz" -C "$scratch_dir"

# Find and delete files containing the line "DELETE ME!"
cd "$scratch_dir/$(basename "$directory")" || exit 1
grep -rl "DELETE ME!" . | xargs rm -f
tar -czf "$clean" "$scratch_dir/$(basename "$directory")"
# in the current directory containing the cleaned contents of the original
# archive, with the name `cleaned_<original-archive-name>.tgz`.
mv "$archive_name" ../..
# Clean up the temporary directory
rm -rf "$scratch_dir"
# If this test fails, you probably didn't name the cleaned archive correctly.