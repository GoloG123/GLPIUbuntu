#!/bin/bash
# Script d'initialisation pour le déploiement automatique de GLPI

echo "=== Mise a jour du systeme ==="
sudo apt update -y && sudo apt upgrade -y

echo "=== Installation du serveur SSH ==="
sudo apt install -y openssh-server
clear
echo "=== Verification du service SSH ==="
sudo systemctl enable ssh
sudo systemctl start ssh
sudo systemctl status ssh --no-pager
clear
echo "=========================================="
IP=$(hostname -I | awk '{print $1}')
echo "Adresse ip = $IP"
echo "=========================================="
echo "Noter l'adresse et appuyer sur ENTER…"
echo "=========================================="
read -p ""  
echo "=== Etape 1 terminée avec succès ==="
echo "=== Etape 2 Installation des services web… ==="
echo "=== Installation d'apache… ==="
sudo apt install apache2 -y
echo "=== Installation de MariaDB… ==="
sudo apt install mariadb-server -y
echo "=== Installation de MySQL & PPH… ==="
sudo apt install php php-mysql php-xml php-mbstring php-curl php-ldap php-gd php-intl php-bcmath -y
clear
echo "=== Telechargement de l'archive GLPI... ==="
cd /tmp
wget https://github.com/glpi-project/glpi/releases/download/11.0.1/glpi-11.0.1.tgz
tar -xvzf glpi-11.0.1.tgz
sudo mv glpi /var/wwww/

echo "=== Telechargement du fichier .htaccess… ==="
wget https://github.com/GoloG123/GLPIUbuntu/blob/4e52807c659c00c7754b5f66da5081fe4d7b786a/.htaccess
sudo mv .htaccess /var/www/glpi/public/
sudo chown www-data:www-data /var/www/glpi/public/.htaccess
sudo chmod 644 /var/www/glpi/public/.htaccess

echo "=== Telechargement du fichier glpi.conf… ==="
wget https://github.com/GoloG123/GLPIUbuntu/blob/4e52807c659c00c7754b5f66da5081fe4d7b786a/glpi.conf
sudo mv glpi.conf /etc/apache2/sites-available/

echo "=== Lancement de la configuration de MySQL… ==="
sudo mysql_secure_installation 
echo "=== Creation DataBase MySQL… ==="
sudo mysql -u root -p


