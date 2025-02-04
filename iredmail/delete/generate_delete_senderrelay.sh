#!/bin/bash

# Input and output file paths
input_file="delete.txt"
output_file="delete_senderrelay.sql"

# Create or overwrite the output file
> "$output_file"

# Loop through each email in user.txt and generate the SQL statement
while IFS= read -r email; do
    echo "DELETE FROM sender_relayhost WHERE account = '$email';" >> "$output_file"
done < "$input_file"

echo "SQL delete statements have been written to $output_file"

