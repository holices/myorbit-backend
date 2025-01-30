# Usa uma imagem otimizada do Node.js
FROM node:18-alpine

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia apenas os arquivos de dependências para otimizar o cache
COPY package.json package-lock.json ./

# Instala apenas dependências de produção
RUN npm install --omit=dev

# Copia o restante do projeto
COPY . .

# Garante que as migrations sejam aplicadas antes de rodar o servidor
RUN npm run migrate:up

# Expõe a porta do Fastify
EXPOSE 3333

# Comando para rodar o servidor
CMD ["npx", "tsx", "src/http/server.ts"]