# User Notification Preferences

Add the ability for users to configure notification preferences across email, push, and in-app channels. Users should control which events trigger notifications and through which channels they're delivered.

This epic covers the backend API, database schema, frontend settings page, and integration with our notification service.

## Acceptance Criteria
- Given a user visits settings, when they open notifications, then they see all event types with channel toggles
- Given a user disables email for "new comment", when a new comment is posted, then no email is sent but push/in-app still fire
- Given a new user signs up, when their account is created, then default notification preferences are created

## Priority
High

## Labels
notifications, user-settings
