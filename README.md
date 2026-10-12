# PB Workspace — IPG · Version 2

Aplikasi pengurusan akademik **offline-first** untuk siswa guru IPG. PWA ringan dengan halaman Ringkasan, Tugasan, Kalendar, Kursus, **Dokumen** dan Peperiksaan. Tiada akaun, pelayan aplikasi, tracker atau kebergantungan CDN.

## Fungsi baharu versi 2

### Dokumen / Documents

- Menu **Dokumen** menempatkan fail mengikut **kursus** dan dua kategori: **Pentaksiran Berterusan** (Continuous Assessment) dan **Maklumat Kursus** (Course Information).
- Tekan **Tambah dokumen** pada kursus/kategori yang dikehendaki, atau **Muat naik dokumen** untuk memilih kursus/kategori dalam borang.
- Pilih sehingga **15 fail bagi satu muat naik**, **maksimum 25 MB bagi setiap fail**. Menyokong PDF, DOC/DOCX, PPT/PPTX, XLS/XLSX, ODT/ODS/ODP, RTF, TXT serta JPG/PNG/WEBP.
- Buka/pratonton PDF, imej dan TXT jika disokong pelayar. Fail Office boleh dimuat turun untuk dibuka dalam aplikasi yang menyokong formatnya.
- Nama fail, saiz, tarikh dan catatan dipaparkan. Anda boleh muat turun atau padam fail, dan pilih kursus untuk menapis senarai.
- Fail sebenar disimpan dalam **IndexedDB** pada peranti, **bukan hanya nama fail dalam localStorage**. Tiada fail dihantar ke pelayan aplikasi. Tiada penyelarasan antara peranti.
- Menukar kod kursus turut mengalihkan dokumen yang berkaitan. Memadam kursus, menetap semula data atau memulakan semester baharu juga melibatkan dokumen, selepas pengesahan.

### Bahasa & tema

- Tekan butang **EN / BM** di penjuru atas untuk beralih antara **Bahasa Melayu dan English**. Bahasa menu, borang, papan pemuka, kalendar, tarikh dan label akan berubah, namun tajuk PB/nama kursus/catatan yang anda taip dikekalkan dalam bahasa asal.
- Tekan ikon **bulan / matahari** untuk menukar **light / dark mode**.
- Kedua-dua pilihan juga tersedia dalam **Tetapan & sandaran**. Pilihan disimpan secara setempat dan kekal selepas aplikasi ditutup/dibuka.

### Sandaran dokumen (penting)

- **Eksport sandaran** kini menghasilkan **satu fail JSON yang merangkumi kursus, PB, peperiksaan dan kandungan semua fail dokumen (base64)**. Fail JSON mungkin besar jika banyak dokumen dimuat naik.
- **Import sandaran** menyokong fail sandaran v1 yang lama (tiada dokumen) serta fail v2. Import *menggantikan* semua data dan dokumen semasa. Had saiz fail JSON import: 180 MB.
- Eksport sandaran sebelum berpindah peranti, memasang semula aplikasi, mengosongkan data pelayar, memadam kursus atau memulakan semester baharu.
- Jangan kongsi sandaran jika fail mengandungi maklumat peribadi/murid/sulit; fail sandaran JSON **tidak disulitkan**.

## Cara memasang pada telefon

1. Ekstrak `PB_Workspace_IPG_Offline_v2.zip`.
2. Muat naik **semua fail dan folder** ke hos statik HTTPS seperti Netlify atau GitHub Pages, termasuk `index.html`, `manifest.webmanifest`, `service-worker.js` dan folder `icons/`.
3. Buka alamat HTTPS aplikasi ketika online buat kali pertama (atau selepas deploy versi baharu). PWA akan menyimpan fail aplikasi untuk kegunaan offline.
4. **Android:** Chrome → menu `⋮` → **Install app** / Add to Home Screen. **iPhone:** Safari → Share → **Add to Home Screen**.
5. Selepas pemasangan, boleh mengurus PB **dan membuka fail yang telah dimuat naik** tanpa sambungan internet. Fail baharu dipilih daripada peranti pengguna.

**Kemas kini daripada v1:** Gunakan **URL/asal domain yang sama** supaya data PB `localStorage` sedia ada tidak hilang. Service worker ditingkatkan kepada cache `v2`; tutup dan buka semula aplikasi jika masih nampak versi lama. Jika berpindah domain, eksport sandaran dari v1 dan import ke v2.

## Versi HTML tunggal

`PB_Workspace_Standalone_v2.html` boleh dibuka untuk mencuba aplikasi di komputer tanpa server. Pada sesetengah pelayar, `file://` mengehadkan `localStorage`/`IndexedDB` atau tidak membenarkan ciri pemasangan PWA. Untuk penggunaan jangka panjang dan dokumen, disyorkan HTTPS; semasa pembangunan di komputer, gunakan pelayan tempatan `python -m http.server 8080` di dalam folder PWA, kemudian buka `http://localhost:8080`.

## Data asal & privasi

Mengandungi enam kursus, 15 PB dan tiga peperiksaan daripada catatan asal. Tarikh catatan tanpa tahun ditafsir sebagai 2026. Tugasan EDUP6023 Google Sites (20 Oktober 2026) dikekalkan sebagai **belum hantar** selaras dengan status yang dicatat. Data tugasan disimpan dalam `localStorage`; dokumen dalam `IndexedDB`; pilihan bahasa/tema dalam `localStorage` berasingan. Sesetengah pelayar mungkin mengosongkan simpanan tempatan apabila ruang peranti berkurangan. Sandarkan data secara berkala.

Had: tiada penyelarasan awan, pemberitahuan latar belakang, penyunting dokumen Office dalam aplikasi, atau binaan APK/IPA natif. Penggunaan storan dokumen bergantung kepada kuota dan dasar pelayar/peranti.
