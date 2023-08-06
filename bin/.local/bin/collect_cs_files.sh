#!/bin/bash

# Check if directory is supplied
if [ $# -eq 0 ]
then
    echo "No directory supplied. Usage: ./scriptname.sh [relative directory]"
    exit 1
fi

# Store the supplied directory
dir=$1

# Remove the output file if it already exists
rm -f output.cs

# Find all .cs files in the specified directory and subdirectories
for file in $(find $dir -name "*.cs")
do
    # Append the content of the file to output.cs
    cat $file >> output.cs
done

