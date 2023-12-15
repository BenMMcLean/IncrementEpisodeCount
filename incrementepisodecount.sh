#!/bin/bash

# Define the directory to process
directory=""

# Define the minimum episode number (formatted as (E)XX, e.g 11) from which you want to increment
start_exx=

change=1

# Change to the target directory
cd "$directory" || { echo "Directory not found. Exiting..."; exit 1; }

# Loop through files in the directory
for file in *; do
  if [[ -f $file && $file =~ (.*S[0-9][0-9]E)([0-9][0-9])(.*) ]]; then
    prefix="${BASH_REMATCH[1]}"
    exx_number="${BASH_REMATCH[2]}"
    rest="${BASH_REMATCH[3]}"
    exx_int=$((10#$exx_number)) # Convert to decimal to handle leading zeros

    if [ "$exx_int" -ge $start_exx ]; then
      new_exx_int=$((exx_int + change))
      new_exx_number=$(printf "%02d" "$new_exx_int") # Format as XX
      new_filename="${prefix}${new_exx_number}${rest}"

      # Rename the file
      mv "$file" "$new_filename"
      echo "Renamed: $file -> $new_filename"
    fi
  fi
done

echo "Processing complete."
