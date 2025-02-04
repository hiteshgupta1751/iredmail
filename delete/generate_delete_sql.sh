#!/bin/bash

# Output SQL file
output_file="delete_users.sql"

# Empty the file before writing
> $output_file

# Loop through each email in user.txt
while IFS= read -r email; do
    domain=$(echo "$email" | cut -d '@' -f 2)

    echo "DELETE FROM mailbox WHERE username = '$email';" >> $output_file
    echo "DELETE FROM forwardings WHERE address = '$email' OR forwarding = '$email';" >> $output_file
done < delete.txt

echo "Generated SQL file: $output_file"

