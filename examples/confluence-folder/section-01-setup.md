# How to Run

## Prerequisites

- Node.js 20+
- RabbitMQ running locally or via Docker
- SendGrid API key (for email)
- Firebase service account JSON (for push)

## Setup

```bash
# Install dependencies
npm install

# Copy environment config
cp .env.example .env
# Edit .env with your API keys

# Run database migrations
npm run migrate

# Start in dev mode
npm run dev
```

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `RABBITMQ_URL` | Yes | RabbitMQ connection string |
| `SENDGRID_API_KEY` | Yes | SendGrid API key for emails |
| `FIREBASE_CONFIG` | Yes | Path to Firebase service account JSON |
| `WS_PORT` | No | WebSocket port (default: 8080) |
| `LOG_LEVEL` | No | Logging level (default: info) |
