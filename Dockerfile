# Stage 1: Build the Remix app
FROM node:18-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app source code
COPY . .

# Build the Remix app
RUN npm run build

# Stage 2: Run the Remix app
FROM node:18-alpine AS runner

# Set the working directory inside the container
WORKDIR /app

# Copy the built app from the builder stage
COPY --from=builder /app /app

# Expose port 3000 to access the app
EXPOSE 3000

# Start the Remix app
CMD ["npm", "run", "start"]