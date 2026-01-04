# Ethernet Bridge

## Other Languages

- [Русская версия](README.ru.md)

A universal network bridge setup script for Linux systems, providing bidirectional port access between devices. Creates a bridge between Wi-Fi and Ethernet with DHCP for connected devices.

## Main Features

- Creation of a network bridge between Wi-Fi and Ethernet interfaces
- DHCP support for automatic IP address assignment to connected devices
- Bidirectional port access between devices
- Support for various Linux distributions (Void Linux, Debian, Ubuntu, CentOS, Arch Linux, etc.)
- Flexible configuration through commands and configuration file
- Automatic detection of the used init system for autostart
- Ability to configure static IP addresses for specific devices
- Network bandwidth management support
- Integration with popular init systems (systemd, OpenRC, s6, runit, SysV)

## Installation

### Using Make:

```bash
make install
```

### Manually:

```bash
sudo cp src/ethernet-bridge /usr/local/bin/
sudo chmod +x /usr/local/bin/ethernet-bridge
```

## Update

To update the script to the latest version, you can perform the following actions:

1. Update the repository:
   ```bash
   git pull origin main
   ```

2. Reinstall the script:
   ```bash
   make install
   ```

## Usage

### Main Commands

BRIDGE MANAGEMENT:
- start - start the bridge
- stop - stop the bridge
- restart - restart the bridge
- status - check bridge status

INFORMATION AND STATUS:
- devices - display device information
- rules - show active rules
- logs - view logs

PORT MANAGEMENT:
- port open <port> - open a port
- port close <port> - close a port
- port list-open - list open ports

CONNECTION CONFIGURATION:
- static-ip <MAC> <IP> - assign a static IP for a MAC address
- set-dns <IP> - set DNS server

NETWORK SETTINGS:
- limit-bandwidth <rate> - limit bandwidth
- remove-bandwidth-limit - remove bandwidth limits

SYSTEM SETTINGS:
- autostart enable - enable autostart
- autostart disable - disable autostart
- info <command> - get system information

### Usage Examples

- Start the bridge: `sudo ethernet-bridge start`
- Check status: `sudo ethernet-bridge status`
- Restart the bridge: `sudo ethernet-bridge restart`
- Show connected devices: `sudo ethernet-bridge devices`
- Show active rules: `sudo ethernet-bridge rules`
- View logs: `sudo ethernet-bridge logs`
- Open a port: `sudo ethernet-bridge port open 8000`
- Close a port: `sudo ethernet-bridge port close 8000`
- Show open ports: `sudo ethernet-bridge port list-open`
- Assign a static IP: `sudo ethernet-bridge static-ip aa:bb:cc:dd:ee:ff 192.168.100.100`
- Set DNS: `sudo ethernet-bridge set-dns 8.8.8.8`
- Limit bandwidth: `sudo ethernet-bridge limit-bandwidth 10mbps`
- Remove bandwidth limit: `sudo ethernet-bridge remove-bandwidth-limit`
- Enable autostart: `sudo ethernet-bridge autostart enable`
- Disable autostart: `sudo ethernet-bridge autostart disable`
- Get system information: `sudo ethernet-bridge info network`

### Autostart

The script automatically detects the used init system (systemd, OpenRC, s6, runit, SysV) and creates the appropriate autostart service:

```bash
# Enable autostart
sudo ethernet-bridge autostart enable

# Disable autostart
sudo ethernet-bridge autostart disable
```

After enabling autostart, the bridge will automatically start when the system boots.

## Configuration

The script supports a configuration file `/etc/ethernet-bridge.conf` where you can set:

- Network interfaces
- DNS settings
- Static IP addresses
- Bandwidth limits
- Open ports

Example configuration file:

```
# Interfaces
WIFI_INTERFACE=wlan0
ETHERNET_INTERFACE=eth0

# Bridge settings
BRIDGE_NAME=br0
BRIDGE_IP=192.168.100.1/24

# DNS servers
DNS_SERVERS="8.8.8.8, 8.8.4.4"

# Bandwidth
BANDWIDTH_LIMIT=100mbps

# Static IP addresses (MAC=IP)
STATIC_IPS=(
    "aa:bb:cc:dd:ee:ff=192.168.100.100"
    "11:22:33:44:55:66=192.168.100.101"
)
```

## Dependencies

The script requires the following to work:

- bridge-utils
- dnsmasq
- iptables
- iproute2 (for tc command if bandwidth limiting is used)
- dhcpcd or dhcpclient (to obtain IP address for Wi-Fi interface)

## Supported Distributions

The script has been tested and works on the following Linux distributions:

- Void Linux
- Debian
- Ubuntu
- CentOS/RHEL
- Fedora
- Arch Linux
- Alpine Linux
- OpenSUSE
- Mint

## Troubleshooting

If you encounter problems with the bridge operation:

1. Check status: `sudo ethernet-bridge status`
2. View logs: `sudo ethernet-bridge logs`
3. Check network interfaces: `ip addr show`
4. Make sure interfaces are correctly specified in the configuration
5. Check if required services are running (dnsmasq, iptables)

## Author

Porkof Nelson

## Updates

Latest update: Added automatic interface detection feature.

## License

GPL-3.0

## Other Languages

- [Русская версия](README.ru.md)