# PB Workspace — IPG Kampus Kota Bharu

PB Workspace ialah aplikasi web untuk mengurus **Pentaksiran Berterusan**, kursus, kalendar akademik, peperiksaan dan dokumen kursus. Antaramuka tersedia dalam bahasa Melayu dan bahasa Inggeris, dengan mod cerah dan gelap.

## Kemas kini paparan

- **Keutamaan terdekat:** permukaan, garis pemisah, tarikh dan teks menggunakan warna berkontras dalam mod gelap.
- **Tugasan:** kotak tanda kemajuan lebih kecil dan kemas, sementara kawasan klik kekal selesa.
- **Kalendar:** merah = PB belum siap, biru = PB siap, hijau = PB dihantar, kuning = peperiksaan. Warna ini digunakan pada penanda tarikh dan butiran tarikh, termasuk mod gelap. Status *siap* dan *dihantar* kekal berasingan.
- Nama aplikasi dipaparkan secara konsisten sebagai **PB Workspace** tanpa label keluaran.

## Pasang pada laman sedia ada

1. **Eksport sandaran** pada telefon dan laptop sebelum menukar fail laman.
2. Ekstrak `PB_Workspace.zip`.
3. Pada Netlify, buka laman PB Workspace **sedia ada** dan deploy folder yang mengandungi `index.html` ke laman tersebut. Jangan cipta laman berasingan jika anda mahu mengekalkan storan pelayar dan tetapan semasa.
4. Muat semula laman pada setiap peranti. Jika PWA masih memaparkan kandungan lama, tutup dan buka semula aplikasi atau bersihkan cache laman dengan berhati-hati (bukan data laman).
5. Pastikan paparan **Rekod terkini** muncul pada kedua-dua peranti sebelum menganggap rekod akademik telah dikemas kini.

## Perkhidmatan data

| Data | Perkhidmatan | Cara kemas kini |
|---|---|---|
| Kursus, tugasan, status siap/hantar, kalendar, peperiksaan, nama paparan | Supabase | Automatik antara peranti yang log masuk menggunakan akaun yang sama, apabila sambungan dan konfigurasi aktif |
| Fail PB dan Maklumat Kursus | Google Drive | Tekan **Hantar fail** atau **Ambil fail** di halaman Dokumen |
| Tema dan bahasa | Peranti sendiri | Disimpan sebagai pilihan setempat |

**Jika rekod akademik belum disambungkan:** Jalankan `supabase.sql` dalam SQL Editor projek Supabase, kemudian tetapkan Project URL dan public publishable/anon key melalui ikon akaun Rekod Langsung dalam aplikasi. Jangan letak secret/service role key dalam laman web. Log masuk dengan akaun yang sama pada semua peranti.

**Jika dokumen belum disambungkan:** Hidupkan Google Drive API bagi projek Google Cloud anda, daftar laman Netlify sebagai Authorized JavaScript origin bagi OAuth Web Client ID, dan pilih Google Drive di halaman Dokumen untuk menyambungkannya. Gunakan kebenaran `drive.file` sahaja.

## Perbezaan status PB

- **Siap / Completed:** tugasan sudah disiapkan; ini tidak bermaksud telah dihantar.
- **Dihantar / Submitted:** tugasan sudah diserahkan. Status ini dikawal berasingan.
- Pada Kalendar, titik hijau diberi keutamaan berbanding biru apabila kedua-duanya ditandakan. Butiran tarikh memaparkan status secara berasingan.

## Fail yang disertakan

- `index.html`: aplikasi PB Workspace
- `manifest.webmanifest` dan `icons/`: aset pemasangan ke skrin utama
- `supabase.sql`: skema pangkalan data dan kawalan akses untuk rekod akademik
- `README.md`: panduan ini

## Semakan

Perubahan gaya dan pemetaan warna boleh diuji tanpa akaun cloud. Penyegerakan rekod sebenar masih bergantung pada akaun Supabase dan Google Drive yang dikonfigurasi; fungsi cloud tidak dianggap disahkan sehingga diuji pada peranti anda sendiri.
