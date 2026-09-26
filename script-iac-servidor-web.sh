#!/bin/bash

set -e

echo "Atualizando o servidor"
apt-get update
apt-get upgrade -y

echo "Instalando dependências"
apt-get install apache2 unzip -y
systemctl enable --now apache2

echo "Baixando e copiando os arquivos da aplicação"
cd /tmp
wget -q "https://github.com/usuario/repositorio/archive/refs/heads/main.zip" -O main.zip
unzip -o main.zip
cd */
cp -R . /var/www/html/

echo "Limpando arquivos temporários"
cd /tmp
rm -rf main.zip

echo "Provisionamento concluído."
