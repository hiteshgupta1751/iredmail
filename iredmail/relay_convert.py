import yaml

# Read the text file
input_file = 'relay.txt'
data = []

with open(input_file, 'r') as file:
    for line in file:
        email, relayhost = line.strip().split()
        formatted_relayhost = f'[{relayhost}]:587'
        data.append({'email': email, 'relayhost': formatted_relayhost})

# Prepare data for YAML output
yaml_data = {'email_relayhost_pairs': data}

# Write to YAML file
output_file = 'relay500.yml'
with open(output_file, 'w') as file:
    yaml.dump(yaml_data, file, default_flow_style=False)

print(f"YAML file '{output_file}' has been created successfully.")

