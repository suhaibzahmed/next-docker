# Stage 1: Build the Next.js app
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY prisma ./prisma
RUN npx prisma generate
COPY . .
RUN npx prisma migrate deploy # Run migrations during build if possible, or keep in CMD for deployment
RUN npm run build # This will create the .next/standalone folder

# Stage 2: Create the production image
FROM node:20-alpine

WORKDIR /app

# Copy standalone output and necessary files
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma 
COPY --from=builder /app/public ./public
COPY prisma ./prisma 

EXPOSE 3000

CMD ["sh", "-c", "npx prisma migrate deploy && node server.js"] # 'server.js' is the entry point for standalone