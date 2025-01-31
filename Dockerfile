# Usa a imagem oficial do Node.js
FROM node:20-alpine

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos necessários
COPY package.json package-lock.json ./
RUN npm install

# Copia o restante do código
COPY . .

# Expõe a porta do Fastify (se necessário)
EXPOSE 3333

# Comando para iniciar o servidor
CMD ["npm", "run", "dev"]