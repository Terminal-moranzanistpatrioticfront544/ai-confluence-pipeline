# Build notification preferences settings page

Create a React settings page where users can view and toggle notification preferences. Display a matrix of event types (rows) vs channels (columns) with toggle switches.

Must support:
- Loading state while fetching preferences
- Optimistic UI updates on toggle
- Error toast if save fails with retry option
- Mobile-responsive layout (stacked on small screens)

## Acceptance Criteria
- Given the settings page loads, when preferences are fetched, then a spinner shows until data arrives
- Given a user toggles a channel, when the toggle is clicked, then the UI updates immediately and the API is called
- Given the API call fails, when the error occurs, then a toast appears with a retry button

## Priority
Medium

## Estimate
L

## Component
frontend
