# Proxmox CPU Temperature Monitor 🌡️

Monitor your Proxmox CPU temperatures and send them to InfluxDB for real-time metrics and analysis! 📈

## Features ✨

- Dynamically handles any number of CPU cores 🖥️
- Configurable measurement names for easy identification of multiple nodes 📊
- Simple setup script to get you started quickly 🚀

## Prerequisites 📋

- An InfluxDB 2 instance running somewhere. You can use [this helper script](https://helper-scripts.com/scripts?id=InfluxDB) to set it up.

## Installation & Setup 🛠️

Run the following one-liner command to set up everything:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/bnap00/proxmox-cpu-temp-monitor/main/setup_cpu_temp_monitor.sh)"
```

The setup script will:
- Install necessary dependencies (`jq`)
- Prompt you for InfluxDB configuration details
- Save these details in a configuration file
- Fetch the main monitoring script from GitHub
- Set up the script with the necessary permissions
- Provide a crontab entry to automate the monitoring script

## Usage 📋

The monitoring script will automatically read the configuration and send CPU temperature data to InfluxDB. You can view and analyze the data using your InfluxDB and Grafana setup.

## Contributions 🤝

Contributions are welcome! Feel free to open an issue or submit a pull request.

---

Made with ❤️ by [bnap00](https://github.com/bnap00)
