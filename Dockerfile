FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies
# Note: strict-ssl is disabled only for build-time npm install due to certificate chain
# issues in some CI/CD environments. Runtime application security is not affected.
# For production, consider using a private npm registry or pre-built node_modules.
RUN npm config set strict-ssl false && \
    npm install --only=production && \
    npm cache clean --force

# Copy application files
COPY app.js ./

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]
