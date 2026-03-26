# Create notification preferences API endpoints

Build REST endpoints for CRUD operations on user notification preferences.

- `GET /api/users/{id}/notification-preferences` — return all preferences
- `PUT /api/users/{id}/notification-preferences` — bulk update preferences
- `PATCH /api/users/{id}/notification-preferences/{eventType}` — update single event

Include input validation, rate limiting, and proper error responses.

## Acceptance Criteria
- Given a valid user ID, when GET is called, then all preferences are returned with channel states
- Given invalid preference data, when PUT is called, then a 400 error with details is returned
- Given a non-existent user, when any endpoint is called, then a 404 is returned

## Priority
High

## Estimate
M

## Component
backend
