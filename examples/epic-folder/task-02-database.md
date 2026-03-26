# Create notification preferences database schema

Design and implement the database schema for storing per-user, per-event notification channel preferences.

Tables needed:
- `notification_event_types` — master list of events (new_comment, mention, task_assigned, etc.)
- `user_notification_preferences` — per-user overrides (user_id, event_type_id, channel, enabled)

Include migration scripts, indexes on user_id + event_type, and seed data for default event types.

## Acceptance Criteria
- Given the migration runs, when the tables are created, then they match the schema spec
- Given a new event type is added to the seed data, when migration runs, then it appears in the event types table
- Given the user_notification_preferences table, when queried by user_id, then it uses the index (no full scan)

## Priority
High

## Estimate
S

## Component
database
