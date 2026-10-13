# PB Workspace v3.1 — IPG Kampus Kota Bharu

Online academic workspace with Google Drive synchronization, bilingual Malay/English UI and light/dark themes.

## Upgrade your existing Netlify website

1. Export a full backup on **each device** from Settings → Export before installing this update.
2. Unzip `PB_Workspace_v3_1_Online.zip`.
3. In Netlify, deploy the extracted project to the **same existing site and domain** as v3. **Do not create a new Netlify site** if you want to retain local device preferences and data.
4. Reload PB Workspace on laptop and phone. If the old app is still shown, force-reload/close and reopen the site; v3.1 retires the previous cache-first service worker.
5. Upgrade **all devices before editing tasks** to avoid older versions silently discarding the new completion and submission fields.
6. Check Google Drive authorization at the globe button on the top bar. As with v3, if you encounter a sync conflict, back up both devices before replacing either version.
7. For the first sync, choose Upload on your source device and Download on the destination device as appropriate. Download replaces destination records.

## Changes

- `PB-W.` wordmark in the sidebar and updated app icons.
- No `Selamat malam`: evening is `Selamat petang` in Malay, `Good evening` in English; afternoon remains `Selamat petang` / `Good afternoon`.
- Editable display name under Settings → Display name, shown as `[Name] • IPG Kampus Kota Bharu` until populated.
- Separate boolean **Completed** and **Submitted** states. Checking completed never submits a task automatically. An independent Submit button controls submission. Both fields are exported/imported and synchronized with workspace JSON.
- Backward-compatible migration: old `pending` → neither; `completed` → completed only; `submitted` → completed and submitted. The legacy `status` string is maintained for compatibility.
- Academic calendar day numbers centered.
- Course cards show **Course Code** in the symbol and **Lecturer name** in the metadata. Lecturer name is editable and included in Drive snapshots.
- Removed the extra upload button next to the Documents page title; the toolbar and category uploads remain.
- Removed legacy offline marketing/copy and offline caching/worker. Browser local data remains a safety copy for sync and previews.
- More consistent layout, spacing, color palette and contrast in both themes.
- Removed Drive and Settings text buttons from the desktop sidebar. Their top-bar icons remain available.
- Breadcrumb now reads `PB Workspace / [tab]`.

## Google Drive usage

- Open the top-bar **globe icon** to connect Google and access Upload / Download / Sync.
- This version reuses the existing Google OAuth Client ID, the `drive.file` scope, folder and workspace data file from v3.
- Your name and lecturer fields are included in new cloud uploads; tasks include `completed` and `submitted` flags.
- This is not a new real-time sync engine: OAuth tokens may expire, and conflicts still require review. Confirm that changes reach Drive before expecting another device to show them.

## Security and data handling

- Never paste a Google OAuth **client secret** into the app. Only a browser OAuth **Client ID** is required.
- Don't share exported workspace backups if they include private academic documents.
- The application continues to use local browser storage to support safe previews and transfers, but its website mode is designed for online synchronization.
- No credentials are bundled in this archive.

## Testing

Chrome browser UI checks: task completion independent of submission, separate submit control, profile and lecturer edits, course code card symbols, calendar centered dates, English/dark mode switching and mobile overflow. Actual Google account synchronization must be verified on the published HTTPS site.
