# Attack Range ⚔️
![Attack Range Logo](docs/attack_range.png)

**Attack Range** est un projet dont l'objectif est de construire des environnements hybrides (cloud & on-premise) sûres pour y réaliser des scénarios complets (attaque, détection et remédiation) pour mettre en avant les capacités de détection du **CyberSOC d'Orange Cyberdefense**

Il est inspiré du projet Open source [Splunk Attack Range](https://attack-range.readthedocs.io/en/latest/) géré par l'équipe de recherche sur les menaces de Splunk.


## Docs
La documentation d'Attack Range peut être trouvé à [Attack Range Documentation](https://wiki.toolbox.prod-client.itm.lan/fr/Projets/Transverses/POCs/attack_range/home)


## Installation 🏗

Installer et configurer Terraform

```shell
curl -s https://releases.hashicorp.com/terraform/1.1.8/terraform_1.1.8_linux_amd64.zip -o terraform.zip && \
unzip terraform.zip && \
mv terraform /usr/local/bin/
```

Installer et configurer awscli

```shell
apt-get install -y awscli
aws configure
```
**N.B:** Il est important de noter que le projet a été adapté pour utiliser uniquement le profil **`accesscsr`**. Dans les prochaines versions il faudra améliorer cette fonctionnalité pour prendre en compte plusieurs profils.


Installer et exécuter poetry qui permet de setup un environnement virtuel permettant d'installer toutes les dépendances du projet.

```shell
curl -sSL https://install.python-poetry.org/ | python -
poetry shell
poetry install
```

Configurer l'Attack Range

```shell
python3 attack_range.py configure
```

A la fin de la configuration, le fichier `attack_range.yml` généré, doit être similaire à celui présenté ci-dessous

```yaml
# Si besoin de customiser, tous les paramètres disponibles se trouvent dans le fichier configs/attack_range_default.yml
general:
  cloud_provider: aws
  attack_range_password: GENERATED_PASSWORD
  use_prebuilt_images_with_packer: '0'
  key_name: key_name
  ip_whitelist: 0.0.0.0/0 # Utiliser son IP publique pour raison de sécurité
  attack_range_name: ar-static-poc # Peut être modifié
aws:
  private_key_path: path_file/key_name.key
  region: eu-west-2
  use_elastic_ips: "0"
windows_servers:
- hostname: ar-win-dc
  windows_image: windows-2016-v3-0-0
  create_domain: '1'
  install_red_team_tools: '1'
  bad_blood: '1'
- hostname: ar-win-2
  windows_image: windows-2016-v3-0-0
  join_domain: '1'
  install_red_team_tools: '1'
linux_servers:
- hostname: ar-linux
```

Construire l'Attack Range

```shell
python3 attack_range.py build
```

L'inventaire du Range Attack est obtenu via la commande

```shell
python3 attack_range.py show
```

Pour arrêter l'Attack Range (Eteindre les instances)

```shell
python3 attack_range.py stop
```

Pour redémarrer l'Attack Range (Redémarrer les instances)

```shell
python3 attack_range.py resume
```

Détruire l'Attack Range (Supprime complètement toutes les instances)

```shell
python3 attack_range.py destroy
```