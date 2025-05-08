# Hyprland Setup


![alt text](2024-11-05-184954_hyprshot.png)

For installation, run:<br/>
```shell
bash <(curl -s https://raw.githubusercontent.com/Jimb0nda/hyprland/main/setup.sh)
```

Run following on fresh install:<br/>
```shell
systemctl enable --now NetworkManager
systemctl enable --now bluetooth
```

To set up fingerprint scanner:<br/>
```shell
fprintd-enroll
```
