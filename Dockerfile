# Use uma imagem base do Python compatível com Poetry
FROM python:3.10-slim

# Instale as dependências do sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
 && rm -rf /var/lib/apt/lists/*

# Instalação do Poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/opt/poetry python -

# Configuração do diretório de trabalho
WORKDIR /app

# Copia os arquivos de configuração do Poetry
COPY pyproject.toml poetry.lock ./

# Instalação das dependências usando o Poetry
RUN poetry install --no-root --no-interaction

# Copia o restante do código fonte para o diretório de trabalho no container
COPY . .

# Comando padrão para executar quando o container for iniciado
CMD ["uvicorn", "store.main:app", "--host", "0.0.0.0", "--port", "8000"]
