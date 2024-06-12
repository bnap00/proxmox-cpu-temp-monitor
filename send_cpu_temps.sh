#!/bin/bash

# Load configuration
source ~/.cpu_temp_config

# Get sensor data in JSON format
sensor_data=$(sensors -j)

# Parse and format the JSON data to InfluxDB line protocol
cpu_temp_data=$(echo "$sensor_data" | jq -r "
  .[\"coretemp-isa-0000\"] |
  to_entries |
  map(
    if .key == \"Package id 0\" and .value.temp1_input != null then
      \"$MEASUREMENT_NAME,core=Package_id_0 package_temp=\(.value.temp1_input)\"
    elif .key | test(\"Core [0-9]+\") then
      .key as \$core |
      .value | to_entries | map(
        select(.key | test(\"temp[0-9]+_input\")) |
        select(.value != null) |
        \"$MEASUREMENT_NAME,core=Core_\((\$core | gsub(\"Core \"; \"\") | tonumber)) core_temp=\(.value)\"
      ) | join(\"\n\")
    else
      empty
    end
  ) |
  join(\"\n\")
")

# Send data to InfluxDB
curl -i -XPOST "$INFLUX_HOST/api/v2/write?bucket=$INFLUX_BUCKET&org=$INFLUX_ORG" \
  -H "Authorization: Token $INFLUX_TOKEN" \
  --data-binary "$cpu_temp_data"
