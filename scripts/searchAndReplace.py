"""
This script automates the process of searching and replacing text within metadata XML files based on a specified set of rules defined in a YAML configuration file. The script is designed to work within different environments (e.g., POOL, DEV, UAT, STG, PROD), with each environment potentially having different replacement texts for the same search pattern. The script supports complex regex patterns for searching and can be easily extended to accommodate additional rules and patterns through the configuration file without modifying the script code.

Usage:
    python searchAndReplace.py <path_to_config.yml>

Arguments:
    <path_to_config.yml> : The path to the YAML configuration file containing the regex patterns and replacement rules.

The script reads the specified YAML configuration file to determine the regex patterns (regex_lib) and the corresponding replacement rules (rules) for each environment. It then iterates over each rule, applying the specified regex pattern to find and replace text within the targeted files. The environment for which replacements are to be made is determined by the TARGET_ENVIRONMENT environment variable, defaulting to 'DEV' if not specified.

Features:
- Supports multiple environments for conditional text replacements.
- Utilizes regex patterns for flexible and powerful search capabilities.
- Reads replacement rules from an external YAML configuration file for easy updates and maintenance.
- Prints informative messages about the operations performed, including files updated and any errors encountered.

Requirements:
- Python 3
- PyYAML package for parsing YAML configuration files.

"""

import os
import re
import yaml
import sys

def load_config(config_path):
    """Load and parse the YAML configuration file."""
    with open(config_path, 'r') as file:
        return yaml.safe_load(file)

def replace_text_in_file(file_path, regex_pattern, replacement_text):
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            file_contents = file.read()

        print(f"Original file contents: {file_contents}")

        # Perform the replacement
        new_contents = re.sub(regex_pattern, replacement_text, file_contents)

        # Directly check if new_contents differ from file_contents
        if new_contents != file_contents:
            with open(file_path, 'w', encoding='utf-8') as file:
                file.write(new_contents)
            print(f"Updated file: {file_path}")
        else:
            print(f"No changes made to: {file_path}")
        
        with open(file_path, 'r', encoding='utf-8') as file:
            file_contents_post = file.read()
        
        print(f"Updated file contents: {file_contents_post}")

    except FileNotFoundError:
        print(f"File not found: {file_path}")

def process_replacements(config, environment, full_path):
    """Process replacement rules for the given environment."""
    regex_lib = config['regex_lib']
    rules = config['rules']
    
    for rule_name, rule_details in rules.items():
        regex_name = rule_details['regex_name']
        regex_pattern = regex_lib[regex_name]
        replacement_text = rule_details['replace_with'][environment]
        
        for file_path in rule_details['files']:
            file_path = full_path + file_path
            print(f"File full path: {file_path}")
            replace_text_in_file(file_path, regex_pattern, replacement_text)

def main(config_path, full_path):
    # Debug print
    print(f"Received TARGET_ENVIRONMENT: {os.getenv('TARGET_ENVIRONMENT')}")

    # Use an environment variable to determine the current environment
    environment = os.getenv('TARGET_ENVIRONMENT', 'DEV').upper()

    if environment not in ['POOL', 'DEV', 'UAT', 'STG', 'PROD']:
        print("Invalid environment. Choose from: POOL, DEV, UAT, STG, PROD")
        exit(1)
    
    config = load_config(config_path)
    process_replacements(config, environment, full_path)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python script.py <path_to_config.yml> <working_directory> <package_directory>")
        exit(1)
    
    config_path = sys.argv[1]
    full_path = sys.argv[2]+"/"+sys.argv[3]+"/"
    print(f"Working directory: {sys.argv[2]}")
    print(f"Package directory: {sys.argv[3]}")
    main(config_path, full_path)

