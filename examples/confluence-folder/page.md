# Notification Service Documentation

Overview of the notification service architecture, setup, and operational procedures.

## Overview

The notification service handles delivery of user notifications across three channels: email (via SendGrid), push (via Firebase), and in-app (via WebSocket). It consumes events from a RabbitMQ queue and routes them based on user preferences.

## Architecture

| Component | Technology | Purpose |
|-----------|-----------|---------|
| Event Consumer | Node.js worker | Pulls events from RabbitMQ |
| Router | Internal module | Checks user preferences, routes to channels |
| Email Sender | SendGrid SDK | Sends transactional emails |
| Push Sender | Firebase Admin | Sends push notifications |
| In-App Sender | WebSocket server | Real-time in-app notifications |

## Key Files

- `src/worker.ts` — Main entry point, connects to RabbitMQ
- `src/router.ts` — Preference lookup and channel routing
- `src/channels/email.ts` — SendGrid integration
- `src/channels/push.ts` — Firebase integration
- `src/channels/inapp.ts` — WebSocket broadcast
