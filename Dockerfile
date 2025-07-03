FROM node:20-alpine

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy Prisma schema and generate client
COPY prisma ./prisma
RUN npx prisma generate

# Copy source code
COPY . .

EXPOSE 3000

# Run migrations and start dev server
CMD ["sh", "-c", "npx prisma migrate deploy && npm run dev"]