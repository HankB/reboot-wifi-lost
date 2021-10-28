# reboot-wifi-lost

Reboot Raspberry Pi if WiFi is lost

## Motivation

Some Raspberry Pi's drop WiFi connection which can be awkward for a headless (IOT) system. This package will test the connection and reboot if the connection is lost for a predetermined length of time. It does this by pinging a specified IP address and if that address goes away, the host will be rebooted. That means the selected IP is critical and if it goes down, the host this package runs on will reboot unnecessarily. If the purpose of the host requires network access, that seems acceptable. If the host performs other duties, they could be unnecessarily interrupted.

## Operation

A Systemd timer fires every 5 minutes and launches a script that pings a preselected host. If the host fails to respond to all pings, the host is rebooted.

## Usage

Tailor the timer and service file to match local needs. In particular the target IP address in `reboot-wifi-lost.service`.

To install:

```text
sudo cp reboot-wifi-lost.timer reboot-wifi-lost.service /etc/systemd/system
sudo systemctl daemon-reload
sudo cp reboot-wifi-lost.sh /usr/local/sbin
sudo systemctl enable reboot-wifi-lost.timer
sudo systemctl start reboot-wifi-lost.timer
sudo systemctl status reboot-wifi-lost.service
sudo systemctl status reboot-wifi-lost.timer
```

## History

Was originally 