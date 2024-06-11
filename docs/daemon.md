# Launch Symphony agent with systemd

We can use systemd unit files to launch Symphony agent at boot.

## Customize the launch script
Edit file `symphony-agent-systemd.sh` to set the path to the `symphony-agent` binary and the `symphony-agent.json` configuration file. The file looks like this:

```bash
BASE_DIR=<your base directory>
$BASE_DIR/symphony-agent -c $BASE_DIR/symphony-agent.json -l Debug
```

## Create a systemd unit file
Customize the base directory configured in the `ExecStart=` option in the `symphony_agent.service` script:

```
[Unit]
Description=Symphony Agent
After=network.target

[Service]
Type=simple
User=demouser
ExecStart=<your base directory>/symphony-agent-systemd.sh
Restart=on-failure

[Install]
WantedBy=default.target
```

We are setting the user that the script will run with the `User=` option and the path to the script with the `ExecStart=` option. The `After=` option ensures that the network is available before starting our script. The various options are documented in the [systemd.exec](https://www.freedesktop.org/software/systemd/man/systemd.exec.html) man page.

Copy the file `symphony_agent.service` into `/etc/systemd/system/`:

```bash
sudo cp symphony_agent.service /etc/systemd/system
chmod +x *.sh
```

## Enable the service
Run the following commands:

```bash
$ sudo systemctl daemon-reload
$ sudo systemctl enable symphony_agent.service
Created symlink /etc/systemd/system/shutdown.target.wants/symphony_agent.service → /etc/systemd/system/symphony_agent.service.
```

This reloads the systemd config and enables our service using the `systemctl` tool (which helps manage systemd services).

## Restart the service

If you need to restart the service just run:

```bash
sudo systemctl restart symphony_agent.service
```

## Check logs

If you need to check the logs for the systemd service just run:

```bash
tail -f /var/log/syslog
```
