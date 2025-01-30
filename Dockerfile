# Usa uma imagem oficial do Node.js
FROM node:20-alpine 

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos do package.json e package-lock.json primeiro para instalar as dependências
COPY package.json package-lock.json ./

# Instala as dependências de produção e desenvolvimento (necessário para drizzle-kit)
RUN npm install 

# Copia o restante do código para dentro do container
COPY . .

# Executa as migrações antes de iniciar o servidor
RUN npx drizzle-kit generate && npx drizzle-kit push

# Define a variável de ambiente para o banco de dados (se necessário)
ENV DATABASE_URL=postgres://docker:docker@pg:5432/myorbit

# Expõe a porta do servidor
EXPOSE 3333

# Comando para rodar o servidor
CMD ["npm", "run", "dev"]
