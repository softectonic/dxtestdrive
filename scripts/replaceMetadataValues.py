import xml.etree.ElementTree as ET
import subprocess
import os
import re

# Register namespaces to prevent 'ns0:' prefixes. Add all namespaces used in your XML files.
ET.register_namespace('', 'http://soap.sforce.com/2006/04/metadata')

# Function to execute anonymous Apex and fetch username
def fetch_username_from_salesforce(email_address):
    temp_file_path = "temp_apex_script.apex"
    try:
        # Write the Apex script to a temporary file
        with open(temp_file_path, "w") as file:
            apex_code = f"""
                List<User> users = [SELECT Username FROM User WHERE Email = '{email_address}' LIMIT 1];
                if (!users.isEmpty()) {{
                    System.debug('DEBUG|' + users[0].Username);
                }}
            """
            file.write(apex_code)
   
        result = subprocess.run(
            ["sfdx", "force:apex:execute", "-f", temp_file_path],
            capture_output=True,
            text=True,
            check=True
        )

        # Optionally, print the output
        print(result.stdout)
        output = result.stdout
        # Regex to find an email address pattern in the debug output
        match = re.search(r"DEBUG(?:\||&#124;)([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})", output)
        if match:
            email_address = match.group(1)  # Extract the email address
            return email_address
    
    except subprocess.CalledProcessError as e:
        print(f"Error executing Apex: {e}")
    finally:
        # Delete the temporary file
        if os.path.exists(temp_file_path):
            os.remove(temp_file_path)
    return None


# Function to replace values in XML based on search criteria
def replace_xml_value(file_path, search_tag, new_value=None, email_address=None):
    # Parse the XML file
    tree = ET.parse(file_path)
    root = tree.getroot()
    
    # Manually extract namespace URI and local name from search_tag
    if '}' in search_tag:
        namespace_uri = search_tag.split('}')[0].strip('{')
        tag_local_name = search_tag.split('}')[1]
    else:
        namespace_uri = None
        tag_local_name = search_tag
    
    # Use the namespace URI directly in findall if it exists
    if namespace_uri:
        # Define the namespace map for finding elements, using a 'default' prefix for simplicity
        namespaces = {'default': namespace_uri}
        # Adjust the findall to use the namespace map
        elements = root.findall('.//default:' + tag_local_name, namespaces)
    else:
        elements = root.findall('.//' + tag_local_name)
    
    for elem in elements:
        if email_address and tag_local_name in ["siteAdmin", "siteGuestRecordDefaultOwner"]:
            # Fetch new value dynamically for certain tags
            dynamic_value = fetch_username_from_salesforce(email_address)
            if dynamic_value:
                elem.text = dynamic_value
        elif new_value:
            elem.text = new_value
    
    # Write the modified XML back to the file
    tree.write(file_path, xml_declaration=True, encoding="UTF-8")

def main():
    # Call the replace_xml_value function with arguments
    replace_xml_value('src/core-crm/main/default/networks/accesslist.network-meta.xml', '{http://soap.sforce.com/2006/04/metadata}emailSenderAddress', 'aashiru@salesforce.com')
    replace_xml_value('src/core-crm/main/default/sites/accesslist.site-meta.xml', '{http://soap.sforce.com/2006/04/metadata}siteAdmin', email_address='aashiru@salesforce.com')

if __name__ == "__main__":
    main()
