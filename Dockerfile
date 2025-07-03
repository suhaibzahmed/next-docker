# Stage 1: Build the Next.js app
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY prisma ./prisma
RUN npx prisma generate

COPY . .
RUN npm run build 

# Stage 2: Create the production image
FROM node:20-alpine

WORKDIR /app

# Copy standalone output and necessary files
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma 
COPY --from=builder /app/public ./public
COPY --from=builder /app/prisma ./prisma

EXPOSE 3000

# Run migrations when container starts (not during build)
CMD ["sh", "-c", "echo 'Waiting for database...' && sleep 10 && npx prisma migrate deploy && echo 'Starting application...' && node server.js"]