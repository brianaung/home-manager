Connect to internet:
```
nmcli device wifi connect <SSID> password <password>
```

Curl the configs:
```
curl -LJO https://github.com/brianaung/home-manager/archive/refs/heads/main.tar.gz
```

Extract:
```
tar -zxvf main.tar.gz
```

Build the system:
```
make NIXNAME=<machine-name> system
```
