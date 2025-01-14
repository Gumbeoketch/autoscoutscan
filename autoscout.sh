#!/bin/bash

# Function to set up ScoutSuite environment
setup_scoutsuite() {
  echo "Setting up ScoutSuite..."
  # Clone the ScoutSuite repository if it doesn't exist
  if [ ! -d "ScoutSuite" ]; then
    git clone https://github.com/nccgroup/ScoutSuite
  fi
  
  cd ScoutSuite || exit
  # Set up a virtual environment
  virtualenv -p python3 venv
  source venv/bin/activate
  pip install -r requirements.txt
  echo "ScoutSuite setup complete."
}

# Function to run AWS Scout Suite scan
run_aws_scan() {
  echo "Running AWS Scout Suite scan..."
  pip install scoutsuite
  scoutsuite aws --report-dir ./aws_report --no-browser
}

# Function to run GCP Scout Suite scan
run_gcp_scan() {
  echo "Running GCP Scout Suite scan..."
  pip install scoutsuite
  echo "$GCP_CREDENTIALS_JSON" > gcp-credentials.json
  scoutsuite gcp --report-dir ./gcp_report --key-file gcp-credentials.json
}

# Function to run Azure Scout Suite scan
run_azure_scan() {
  echo "Running Azure Scout Suite scan..."
  pip install scoutsuite
  scoutsuite azure --report-dir ./azure_report --client-id "$AZURE_CLIENT_ID" --client-secret "$AZURE_CLIENT_SECRET" --subscription-id "$AZURE_SUBSCRIPTION_ID" --tenant-id "$AZURE_TENANT_ID"
}

# Main menu
echo "Starting ScoutSuite..."
setup_scoutsuite

echo "Select a cloud service provider:"
echo "1. AWS"
echo "2. GCP"
echo "3. Azure"

read -p "Enter your choice (1/2/3): " choice

case $choice in
  1) run_aws_scan ;;
  2) run_gcp_scan ;;
  3) run_azure_scan ;;
  *) echo "Invalid choice. Please select 1, 2, or 3." ;;
esac
