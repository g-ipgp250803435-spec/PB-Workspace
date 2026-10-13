# PB Workspace v3.2 — automatic academic records + Google Drive document files

## What changed
- Ringkasan, Tugasan (Completed and Submitted independently), Kalendar, Kursus, Peperiksaan, and profile display name synchronize **automatically** through Supabase PostgreSQL + Realtime when signed in. There are no routine Upload/Download buttons for academic records.
- PB and MK file contents are stored on the current device and are transferred using **Google Drive** buttons in the Dokumen toolbar: **Hantar fail / Upload files** and **Ambil fail / Get files**. You may manually transfer documents at any time. Google Drive is not used for task/course/exam JSON snapshots anymore.
- Existing v3.1 layout, dark/light themes, bilingual interface and Drive document library are retained.

## One-time setup (required for automatic cross-device records)
1. Back up your current PB Workspace data separately from every device before deploying v3.2. In particular, reconcile any existing phone/laptop differences first: **this migration does not automatically merge pre-existing v3.1 Drive snapshot conflicts.**
2. Create a project at https://supabase.com/dashboard and open **SQL Editor**. Run the bundled `supabase.sql` in full. It creates a per-user `pb_records` table with Row Level Security and a compare-and-swap revision function.
3. In Supabase Authentication, enable Email authentication; confirm your email if required. Use the same Supabase account on both devices.
4. Deploy *all* application files to your existing Netlify HTTPS site. Open the website on the primary device. Click the top-right **Rekod Langsung / Live records** icon (or Settings → Automatic record updates); enter your **Supabase Project URL** and **publishable/anon key** (never the service role/secret key), save, and sign up or log in.
5. On an empty Supabase account, the primary device's academic records are initialized automatically. Check that the status becomes **Records up to date**, and verify your courses and task states. Allow initial synchronization to finish.
6. On your second device, open the *same* deployed URL, configure the *same* Supabase project URL and publishable key, then sign in to the *same* account. The existing cloud records are downloaded automatically. Back up any local academic data on that device **first**: its local records may be replaced during first sign-in.
7. Test: mark a task Completed on phone, leave the webpage open long enough to show **Records up to date**, then open/activate the laptop page. The task should update automatically. Task Completed does not mark Submitted.

## Documents (Google Drive only)
1. Open **Dokumen → Google Drive**, provide the **Google OAuth web Client ID** from your existing v3 setup and **Connect Google**.
2. Add PB/MK documents to a course. Select **Hantar fail / Upload files** to store the file contents in the `PB Workspace` folder of your Drive. On the other device, connect Google in the Documents tab and select **Ambil fail / Get files**.
3. PB/MK file uploads/downloads are manual as requested. Documents use Google Drive `drive.file` scope. Records never require clicking these buttons.

## Notes & safeguards
- **Supabase is necessary** for dependable automatic per-record synchronization in this build. Google Drive remains the file store only, so there are two one-time connections. Neither external account is preconfigured in the download.
- Local record edits queue until signed in and online; reconnecting retries them. The status in the header shows whether edits remain pending. The webpage must be opened and authenticated for its sync engine to run; a closed browser does not perform background sync.
- If two devices edit *the same record* before synchronizing, automatic conflict protection holds the later upload and asks you to review it. It does not silently overwrite the remote edit or merge both fields. Export a backup before choosing either version.
- Supabase Auth persists sessions in the browser. Protect your account and keep RLS enabled. Never include service-role keys in client-side HTML.
- Live Supabase + Google login tests require your own credentials/project and were not executed in this build. Browser UI tests were run without external credentials.
