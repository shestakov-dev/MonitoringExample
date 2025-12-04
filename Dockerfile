FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies with SSL disabled for Docker build
RUN npm config set strict-ssl false && \
    npm install --only=production && \
    npm cache clean --force

# Copy application files
COPY app.js ./

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]
