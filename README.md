Создать файл monitor_logins.sh в /root/
sudo chmod +x /root/monitor_logins.sh
sudo nano /etc/systemd/system/monitor-logins.service
[Unit]
Description=Monitor logins and send Telegram notifications
After=network.target
[Service]
ExecStart=/root/monitor_logins.sh
Restart=always
[Install]
WantedBy=multi-user.target

sudo systemctl start monitor-logins.service
sudo systemctl enable monitor-logins.service
