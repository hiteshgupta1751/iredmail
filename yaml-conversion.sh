#!/bin/bash

# Function to generate a strong password with the first letter as an alphabet
generate_strong_password() {
    # Generate the first character as an alphabet
    first_char=$(tr -dc '[:alpha:]' < /dev/urandom | head -c 1)

    # Generate the rest of the password with alphanumeric characters and symbols
    rest=$(tr -dc '[:alnum:]!@#$%^&*()_+=' < /dev/urandom | head -c 22)

    # Combine the first character with the rest of the password
    password="$first_char$rest"

    echo "$password"
}

# Start YAML output
echo "domains:" > user.yaml

# Initialize variables to hold domain and password
current_domain=""
domain_password=""
declare -a users

# Function to write users to the YAML file
write_users_to_yaml() {
    if [[ ${#users[@]} -gt 0 ]]; then
        echo "    users:" >> user.yaml
        for user in "${users[@]}"; do
            echo "      - { username: ${user%,*}, password: \"$domain_password\", display_name: ${user#*,} }" >> user.yaml
        done
    fi
}

# Read user.txt file line by line
while IFS= read -r line || [[ -n "$line" ]]; do
    # Trim leading and trailing whitespace
    line=$(echo "$line" | xargs)

    # Skip empty lines
    if [[ -z "$line" ]]; then
        continue
    fi

    # Check if line is a domain
    if [[ "$line" =~ \.com$|\.org$|\.net$|\.co$ ]]; then
        # If there is a current domain, write its users
        if [[ -n "$current_domain" ]]; then
            write_users_to_yaml
        fi

        # Start a new domain
        current_domain="$line"
        domain_password=$(generate_strong_password)
        echo "  - name: $current_domain" >> user.yaml

        # Reset users array
        users=()
    else
        # Parse username and display name
        username=$(echo "$line" | cut -d ':' -f 1)
        display_name=$(echo "$line" | cut -d ':' -f 2-)

        # Add to users array if neither is empty and valid
        if [[ -n "$username" && -n "$display_name" ]]; then
            users+=("$username,$display_name")
        fi
    fi
done < user.txt

# Write the last domain's users
if [[ -n "$current_domain" ]]; then
    write_users_to_yaml
fi

echo "YAML file 'user.yaml' has been generated."

