# Network

HassOS uses NetworkManager to control the host network. In future releases, you can set up the configuration using the API/UI.
Currently only manual configuration using NetworkManager connection files is supported. Without a configuration file, the device will use DHCP by default. These network connection files can be placed on a USB drive as described in [Configuration][configuration-usb].

## Configuration Examples

You can look also into [Official Manual][keyfile] or there are a lot of examples accross internet. The system is read only, if you not want change the IP address every boot, you should set the uuid property with a generic [UUID4][uuid].

### Default

We have a preinstalled connection profile:
```
[connection]
id=HassOS default
uuid=f62bf7c2-e565-49ff-bbfc-a4cf791e6add
type=802-3-ethernet

[ipv4]
method=auto

[ipv6]
addr-gen-mode=stable-privacy
method=auto
```

### LAN
```ini
[connection]
id=hassos-network
uuid=d55162b4-6152-4310-9312-8f4c54d86afa
type=802-3-ethernet

[ipv4]
method=auto

[ipv6]
addr-gen-mode=stable-privacy
method=auto
```

### Wireless WPA/PSK
```ini
[connection]
id=hassos-network
uuid=72111c67-4a5d-4d5c-925e-f8ee26efb3c3
type=802-11-wireless

[wifi]
mode=infrastructure
ssid=MY_SSID

[wifi-security]
auth-alg=open
key-mgmt=wpa-psk
psk=MY_WLAN_SECRED_KEY

[ipv4]
method=auto

[ipv6]
addr-gen-mode=stable-privacy
method=auto
```

### Static IP

Replace follow configs:
```ini
[ipv4]
method=manual
address1=192.168.1.111/24,192.168.1.1
dns=8.8.8.8;8.8.4.4;
```

## Tips

### Reset network

If you want reset the network configuration to default, use follow commands on host:
```bash
$ rm /etc/NetworkManager/system-connections/*
$ cp /usr/share/system-connections/* /etc/NetworkManager/system-connections/
$ nmcli con reload
```

### Powersave

If you have trouble with powersave you can do following:
```ini
[wifi]
# Values are 0 (use default), 1 (ignore/don't touch), 2 (disable) or 3 (enable).
powersave=0
```

[keyfile]: https://developer.gnome.org/NetworkManager/stable/nm-settings.html
[configuration-usb]: configuration.md
[uuid]: https://www.uuidgenerator.net/
