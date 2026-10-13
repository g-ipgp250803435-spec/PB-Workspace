# PB Workspace v3 — Google Drive Edition

**Malay / English · Light / dark mode · Offline-first PWA · Cross-device sync using your own Google Drive**

This version replaces the v3 Supabase adapter with **Google Drive only**. No Supabase project, database, or server-side password storage is needed. The app still works offline for all existing local records and downloaded documents, with optional Google Drive synchronization while online.

## What is in this folder

- `index.html`: mobile/desktop planner, documents, preferences, and Google Drive sync.
- `service-worker.js`, `manifest.webmanifest`, `icons/`: installation and offline shell.
- `README.md`: setup, migration, safety, and limitations.

### How Google Drive is used

After you authorize the app, PB Workspace creates a visible **PB Workspace** folder in your Google Drive:

```text
My Drive /
  PB Workspace /
    pb-workspace-data.json   # courses, PB, exams, document index
    MPU6122 /
      role-play.pdf
    PKUK6013 /
      kit-digital.pptx
    ...
```

Folder names follow course codes on *initial file upload*; renaming a course in the app updates its document association in the app but does not move previously uploaded files into a renamed Drive folder. Uploaded files remain private unless you change sharing permissions yourself.

The app only asks for Google's **`https://www.googleapis.com/auth/drive.file`** OAuth scope, meaning it can access files made or expressly opened by this app, not all files in your Google Drive. Documents and records are also cached locally on each device (browser `localStorage` + `IndexedDB`). Google access tokens live **only in memory** and must be renewed using the Connect button once expired or after the app has been closed.

## Setup: Google Cloud (one-time)

1. Visit https://console.cloud.google.com/ and create or select a **Google Cloud project**.
2. Under **APIs & Services > Library**, enable **Google Drive API**.
3. Under **Google Auth Platform / OAuth consent screen**, set the app name, audience, and required contact details. If using **External / Testing**, add your Google email to **Test users**. Add the `drive.file` scope and any other Google-required configuration. A public release may require additional consent-screen setup/verification.
4. Under **Clients / Credentials**, create an **OAuth 2.0 Client ID** of type **Web application** (not Desktop or Android). Add the exact URL origin of your deployed site to **Authorized JavaScript origins**, e.g. `https://my-pb-workspace.netlify.app`. The origin must match the site you open on every device, including scheme and host; do not include the path. During local development you may add `http://localhost:<port>`.
5. Copy the **OAuth Client ID** (ending `.apps.googleusercontent.com`). **Never** put a Google *client secret* or service-account private key in this application.
6. Deploy the *contents of this ZIP* (not a nested folder inside it) to HTTPS static hosting such as Netlify, GitHub Pages or Cloudflare Pages. Google OAuth **will not work by opening the HTML directly as `file://`**.
7. Open **Google Drive · v3** (globe button at the top or sidebar), enter your Web Client ID, click **Save ID**, then **Connect Google**. Approve the app's limited Drive file scope.

### On your original/main device

1. **Before replacing your existing v2/v3 deployment, export a JSON backup** from Settings on the current app. It includes all cached files.
2. Deploy this version to the **same HTTPS origin** as your previous app to preserve the browser's localStorage and IndexedDB. Switching domains creates a separate, empty local storage area. If you switch domains, import the exported JSON backup first.
3. In PB Workspace v3, connect your Google account and press **Upload**. This sends the current local courses, PB tasks, exams, and documents to Google Drive.
4. If Drive already contains a PB Workspace, the app asks for confirmation before replacing it. Make backups of both devices first.

### On a second phone, tablet, or laptop

1. Open the **same hosted PB Workspace URL** and enter the **same Google OAuth Client ID** on that device.
2. Connect to **the same Google account**. Choose **Download** to bring the main device's workspace (including documents) into offline local storage.
3. Once first sync is established, local changes upload when the app is open, online, and the Google access token is valid; unchanged devices periodically check for newer data. The app never guarantees sync while closed or while offline.
4. If Google authorization expires, tap **Connect Google** again. Unsynced edits stay on the device.

## Security and sync behavior

- **No Supabase**: Google Drive stores both individual document blobs and a JSON workspace snapshot.
- **Not a Google Drive mirror**: The app does not scan or import arbitrary personal Drive files. Only files created by this OAuth app are accessed.
- **Offline-first**: All previously imported/downloaded document blobs are saved in IndexedDB; records are stored in localStorage. Browser storage may be cleared by the OS/browser, particularly under storage pressure or in private mode. Export manual JSON backups regularly.
- **First sync is manual**: This prevents an empty second device from overwriting a full first device.
- **Conflicts**: The app checks Drive's file `version` before overwriting it. If another device has published a newer version, a conflict is reported and no upload is made. **This is a best-effort version check, not a transaction/atomic lock**; truly simultaneous writes could still race. Back up both devices and avoid editing from multiple offline devices simultaneously. There is no field-level merge.
- **Overwriting on Download**: Download replaces ALL local course/task/exam and document data. Export a backup first. Incomplete downloads should not replace cached document data.
- **Deleted files**: Deleting a document in the app removes it locally and schedules its removal from the Drive workspace on the next successful upload. Old Drive files are moved to Drive Trash only after the updated workspace data file has been saved. If trash cleanup fails, old Drive blobs may remain in your folder but no longer appear in the app.
- **Google account**: On account changes the app resets its cloud revision reference but retains the local content and requires an explicit first upload/download. Disconnect removes the access token from this page but does not remove your existing Drive files or local data.
- **Limits**: 25 MB per uploaded document, maximum 15 files per batch, with available Drive storage and API quotas applying. Uploads above 5 MB use Drive's resumable upload API. Internet is required for OAuth and cloud transfers, but not local viewing/editing.
- **Privacy**: Do not publish the `pb-workspace-data.json` as a public Drive share link. The app requests the limited `drive.file` scope, but a compromised device or malicious browser extension could still access cached academic data.

## Testing and production readiness

The app's JavaScript is syntax-checked and its static structure and data migration were reviewed. It has **not** been verified against a live Google account and real Android/iOS browsers. Google OAuth, Drive permissions, upload/download, quota edge cases, and offline restoration require end-to-end testing on your own configured Google Cloud project. This is a usable **development build**, not a guaranteed production backup system.

Official docs:
- https://developers.google.com/identity/oauth2/web/guides/use-token-model
- https://developers.google.com/workspace/drive/api/guides/api-specific-auth
- https://developers.google.com/workspace/drive/api/guides/manage-uploads
- https://developers.google.com/identity/gsi/web/guides/get-google-api-clientid
