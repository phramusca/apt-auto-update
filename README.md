# apt-auto-update

Small **all-architecture** Debian package (`all`): one command to run `apt update`, `upgrade`, `autoremove`, `autoclean`, and `clean` in sequence, with optional **cron** scheduling (as root) and **log rotation**.

Intended for any **APT**-based system: Raspberry Pi OS, **WSL** with Ubuntu/Debian, and other.

> Whenever possible, use your distribution’s built-in auto update tools instead of this package. For example, Linux Mint and some other distributions provide their own automatic update features.

---

## For users

### Prerequisites at runtime

The package declares dependencies on `cron` (or an equivalent), `logrotate`, and `sudo`.

### Install from `.deb`

```bash
sudo apt install ./apt-auto-update_*_all.deb
```

### Usage

| Command                                  | Action                                                                 |
| ---------------------------------------- | ---------------------------------------------------------------------- |
| `sudo apt-auto-update run`               | Run maintenance now                                                    |
| `sudo apt-auto-update enable`            | Daily cron at **12:00** (noon), log `/var/log/apt-auto-update.log`     |
| `sudo apt-auto-update enable --hour 2`   | Same at **2:00**                                                       |
| `sudo apt-auto-update disable`           | Remove the `/etc/cron.d/apt-auto-update` fragment created by the tool |
| `apt-auto-update status`                 | Show whether scheduling is active                                      |

- Installing the package **does not** enable cron; run `enable` when you want it.
- **`apt remove`**: the generated cron entry is removed (`debian/prerm`).
- **`apt purge`**: `apt-auto-update` log files are removed (`debian/postrm`); the logrotate file is a normal Debian conffile.
- Logs stay **plain text** (no gzip) for easy reading.

### Installed files

- `/usr/bin/apt-auto-update`
- `/usr/lib/apt-auto-update/run-maintenance.sh`
- `/etc/logrotate.d/apt-auto-update` → `/var/log/apt-auto-update.log`

License: **GPL-3+** (see `debian/copyright` and `LICENSE`).

---

## For developers

### Build the `.deb`

From the repository root:

```bash
./build-apt-auto-update.sh
```

Output:

- `apt-auto-update_<version>_all.deb` in the repository root (one level above the `apt-auto-update/` source directory)

Prerequisites:

- `build-essential`, `debhelper`, `fakeroot` (provides `dpkg-buildpackage` and helpers)

### Clone, build, and install locally

```bash
git clone https://github.com/phramusca/apt-auto-update.git
cd apt-auto-update
sudo apt install build-essential debhelper fakeroot
./build-apt-auto-update.sh
sudo apt install ./apt-auto-update_*_all.deb
```
