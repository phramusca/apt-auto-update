# apt-auto-update

Petit paquet Debian **tout architecture** (`all`) : une commande pour enchaîner `apt update`, `upgrade`, `autoremove`, `autoclean` et `clean`, avec possibilité de **planifier** ça via **cron** (root) et **rotation des journaux**.

Conçu pour tout système basé sur **APT** : Debian, Ubuntu, Raspberry Pi OS, **WSL** avec Ubuntu/Debian, etc. Ce n’est **pas** réservé au Raspberry Pi.

## Prérequis

- `build-essential`, `debhelper`, `fakeroot` (pour construire le `.deb`)
- À l’exécution : `cron` (ou équivalent), `logrotate`, `sudo` — déclarés comme dépendances du paquet

## Construire le paquet

```bash
sudo apt install build-essential debhelper fakeroot
dpkg-buildpackage -us -uc -b -rfakeroot
```

Le fichier `apt-auto-update_<version>_all.deb` est créé dans le **répertoire parent** (un niveau au-dessus de ce dépôt si tu es dans la racine du clone).

```bash
sudo apt install ./apt-auto-update_*_all.deb
```

## Utilisation

| Commande                               | Rôle                                                                   |
| -------------------------------------- | ---------------------------------------------------------------------- |
| `sudo apt-auto-update run`             | Lance la maintenance tout de suite                                     |
| `sudo apt-auto-update enable`          | Cron quotidien à **4h** (root), journal `/var/log/apt-auto-update.log` |
| `sudo apt-auto-update enable --hour 2` | Idem à **2h**                                                          |
| `sudo apt-auto-update disable`         | Supprime le fragment `/etc/cron.d/apt-auto-update` créé par l’outil    |
| `apt-auto-update status`               | Indique si la planification est active                                 |

- L’installation du paquet **n’active pas** le cron : lancer `enable` quand tu le souhaites.
- **`apt remove`** : le cron généré est retiré (`debian/prerm`).
- **`apt purge`** : suppression des journaux `apt-auto-update` (`debian/postrm`) ; le fichier logrotate est un conffile Debian classique.
- Logs en **clair** (pas de compression gzip) pour rester lisibles facilement.

## Fichiers installés

- `/usr/bin/apt-auto-update`
- `/usr/lib/apt-auto-update/run-maintenance.sh`
- `/etc/logrotate.d/apt-auto-update` → `/var/log/apt-auto-update.log`

Licence : **GPL-3+** (voir `debian/copyright` et `LICENSE`).

**Construire et installer** :

```bash
git clone https://github.com/phramusca/apt-auto-update.git
cd apt-auto-update
sudo apt install build-essential debhelper fakeroot
dpkg-buildpackage -us -uc -b -rfakeroot
sudo apt install ../apt-auto-update_*_all.deb
```
