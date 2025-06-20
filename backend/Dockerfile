# Usa uma imagem base Python
FROM python:3.12-slim-bookworm

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Instala as dependências do sistema necessárias
# Isso incluiria libpq-dev para psycopg2 e libsqlite3-dev para _sqlite3
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    sqlite3 \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copia os arquivos de requisitos e instala as dependências Python
COPY requirements/base.txt .
COPY requirements/production.txt .
RUN pip install -r base.txt -r production.txt

# Copia o restante do seu código
COPY . .

# Define a variável de ambiente para as configurações do Django (ajuste conforme seu projeto)
ENV DJANGO_SETTINGS_MODULE=backend.core.config.settings.production

# Comando para rodar as migrations e coletar estáticos durante o build (se necessário no contêiner)
# Ou você pode fazer isso em um script de entrada ou no comando de deploy do Vercel
RUN python core/manage.py migrate --noinput
RUN python core/manage.py collectstatic --noinput

# Comando para iniciar o servidor Gunicorn (pode ser o CMD do Dockerfile ou o comando de start do Vercel)
CMD ["gunicorn", "backend.core.wsgi:application", "--bind", "0.0.0.0:$PORT"]