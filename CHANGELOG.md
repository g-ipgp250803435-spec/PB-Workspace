# PB Workspace v3 — Google Drive Edition

## New in this build

- Replaced Supabase Cloud Sync with a Google Drive–only adapter.
- Google Identity Services OAuth browser authorization (limited `drive.file` scope).
- Documents uploaded individually into course-coded folders on Google Drive.
- Workspace data (courses, PB records, exams and document index) stored in a JSON file in the same Drive folder.
- Offline-first PWA continues to cache all records and downloaded document contents locally.
- First-device upload / second-device download onboarding, manual sync and periodic checks while online.
- Best-effort Drive file-version conflict checks, blocking a known stale overwrite.
- Keeps v2 bilingual BM/EN, light/dark mode, Documents, Calendar, Courses, Exams and backups.

## Known limitations

- Google Cloud Console project and an OAuth **Web client ID** required; no credentials embedded in the app.
- Short-lived tokens must be renewed after reopening the app. No background sync when closed.
- Concurrent updates on different devices are not merged, and Drive version checks are not atomic.
- Real Google OAuth and physical-device testing are still outstanding.
