#!/usr/bin/env bash

echo "Instalando as dependências..."
pip3 install -r requirements/production.txt

echo "Migrando banco de dados..."
python3 core/manage.py makemigrations --noinput
python3 core/manage.py migrate --noinput

echo "Coletando arquivos estáticos..."
python3 core/manage.py collectstatic --noinput
