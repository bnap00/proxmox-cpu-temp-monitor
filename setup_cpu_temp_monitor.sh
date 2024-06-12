#!/bin/bash

# Install dependencies
sudo apt-get update
sudo apt-get install -y jq

# Prompt for InfluxDB parameters
read -p "Enter InfluxDB bucket: " INFLUX_BUCKET
read -p "Enter InfluxDB organization: " INFLUX_ORG
read -p "Enter InfluxDB token: " INFLUX_TOKEN
read -p "Enter InfluxDB host (e.g., http://localhost:8086): " INFLUX_HOST
read -p "Enter CPU temperature measurement name: " MEASUREMENT_NAME

# Create the configuration file
cat << EOF > ~/.cpu_temp_config
INFLUX_BUCKET="$INFLUX_BUCKET"
INFLUX_ORG="$INFLUX_ORG"
INFLUX_TOKEN="$INFLUX_TOKEN"
INFLUX_HOST="$INFLUX_HOST"
MEASUREMENT_NAME="$MEASUREMENT_NAME"
EOF

echo "Configuration saved to ~/.cpu_temp_config"

# Fetch the main script from GitHub
curl -o /usr/local/bin/send_cpu_temps.sh https://raw.githubusercontent.com/bnap00/proxmox-cpu-temp-monitor/main/send_cpu_temps.sh

# Make the main script executable
chmod +x /usr/local/bin/send_cpu_temps.sh

# Echo the crontab entry
echo "Add the following line to your crontab:"
echo "* * * * * /usr/local/bin/send_cpu_temps.sh >> /var/log/cpu_temp.log 2>&1"
