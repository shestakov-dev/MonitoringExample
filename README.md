# MonitoringExample

A simple Express.js application with Prometheus metrics monitoring.

## Overview

This project demonstrates how to:
- Create an Express.js REST API with multiple endpoints
- Integrate Prometheus metrics using `prom-client`
- Set up Prometheus in Docker to scrape and monitor the application metrics

## Features

### REST API Endpoints

- `GET /` - Welcome message
- `GET /api/users` - Get list of users
- `GET /api/status` - Get application status
- `POST /api/users` - Create a new user
- `GET /health` - Health check endpoint
- `GET /metrics` - Prometheus metrics endpoint

### Metrics Collected

- **Default metrics**: CPU usage, memory usage, event loop lag, etc.
- **Custom metrics**:
  - `http_requests_total`: Counter for total HTTP requests by method, route, and status code
  - `http_request_duration_seconds`: Histogram for HTTP request duration

## Prerequisites

- Node.js 18+ (for local development)
- Docker and Docker Compose (for containerized setup)

## Running Locally

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start the application:
   ```bash
   npm start
   ```

3. The application will be available at `http://localhost:3000`

4. View metrics at `http://localhost:3000/metrics`

## Running with Docker Compose

1. Build and start all services:
   ```bash
   docker-compose up --build
   ```

2. Access the services:
   - Express API: `http://localhost:3000`
   - Prometheus UI: `http://localhost:9090`
   - Metrics endpoint: `http://localhost:3000/metrics`

3. Stop the services:
   ```bash
   docker-compose down
   ```

## Testing the Endpoints

```bash
# Get welcome message
curl http://localhost:3000/

# Get users
curl http://localhost:3000/api/users

# Get status
curl http://localhost:3000/api/status

# Create a user
curl -X POST http://localhost:3000/api/users \
  -H "Content-Type: application/json" \
  -d '{"name": "John Doe"}'

# Check health
curl http://localhost:3000/health

# View metrics
curl http://localhost:3000/metrics
```

## Prometheus Configuration

The Prometheus configuration (`prometheus.yml`) is set to:
- Scrape metrics from the Express app every 5 seconds
- Target the `/metrics` endpoint at `app:3000` (when using Docker Compose)

You can view the scraped metrics in the Prometheus UI at `http://localhost:9090` and run queries like:
- `http_requests_total` - Total requests count
- `rate(http_requests_total[1m])` - Request rate per minute
- `http_request_duration_seconds` - Request duration histogram

## Project Structure

```
.
├── app.js                    # Express.js application
├── package.json             # Node.js dependencies
├── Dockerfile               # Dockerfile for Express app
├── Dockerfile.prometheus    # Dockerfile for Prometheus
├── docker-compose.yml       # Docker Compose configuration
├── prometheus.yml           # Prometheus configuration
└── README.md               # This file
```