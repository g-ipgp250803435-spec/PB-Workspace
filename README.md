# PB Workspace — IPG (Offline PWA)

Aplikasi ringan pengurusan Pentaksiran Berterusan (PB) dan peperiksaan akhir IPG. Dibina sebagai **Progressive Web App (PWA)** tanpa rangka kerja, API, akaun atau sambungan rangkaian pihak ketiga. Data disimpan dalam `localStorage` pada peranti, dan fail aplikasi disimpan dalam cache PWA untuk kegunaan offline.

## Cara guna terus pada komputer

1. Ekstrak ZIP.
2. Buka `index.html` menggunakan pelayar web. Ia tidak memerlukan internet, tetapi sesetengah pelayar mengehadkan penyimpanan `localStorage` apabila membuka fail melalui `file://`.
3. Untuk pengalaman yang lebih stabil, jalankan pelayan tempatan dalam folder tersebut: `python -m http.server 8080`, kemudian buka `http://localhost:8080`.

## Cara pasang pada telefon (disyorkan)

PWA perlu dibuka melalui pautan **HTTPS** untuk pemasangan dan offline cache, sekali sahaja untuk kali pertama.

1. Ekstrak ZIP lalu muat naik **keseluruhan isi folder** ke hos statik HTTPS seperti GitHub Pages atau Netlify Drop. Pastikan `index.html`, `service-worker.js`, `manifest.webmanifest`, dan direktori `icons/` berada pada aras yang sama.
2. Buka pautan HTTPS tersebut pada telefon ketika ada internet. Biarkan halaman dimuatkan dahulu supaya fail aplikasi disimpan dalam cache.
3. **Android (Chrome):** menu `⋮` → **Install app / Add to Home screen**.
4. **iPhone (Safari):** butang Share → **Add to Home Screen** → Add.
5. Selepas itu buka dari skrin utama. Aplikasi boleh digunakan tanpa internet; tugasan dan perubahan status disimpan setempat pada peranti yang sama.

**Nota:** Mod offline PWA berfungsi selepas lawatan pertama melalui HTTPS dan service worker dipasang. Pengguna perlu membuat sandaran sebelum memadam data pelayar atau menukar peranti.

## Fungsi

- Dashboard dengan kemajuan, PB belum selesai, PB selesai dan keutamaan tarikh akhir secara automatik.
- Semua tugasan boleh ditambah, disunting, dipadam dan ditandakan dihantar/selesai.
- Carian, penapisan mengikut status dan kursus.
- Kalendar bulanan dengan penunjuk tugasan dan peperiksaan.
- Kemajuan mengikut kursus; tambah, edit, dan padam kursus mengikut keperluan semester.
- Fungsi **Mulakan semester baharu**: eksport sandaran kemudian kosongkan rekod semester lama.
- Senarai peperiksaan akhir dan pengurusan tarikh peperiksaan.
- Eksport/import sandaran data JSON.
- Navigasi mobile, icon aplikasi, tiada dependensi luaran.

## Data contoh

Berdasarkan butiran enam kursus (15 PB) dan tiga peperiksaan yang diberikan. Tarikh tanpa tahun pada catatan asal ditafsir sebagai **2026** dan boleh disunting. Pada 11 Oktober 2026, contoh permulaan mempunyai **7 tugasan belum selesai** dan **8 telah selesai**. **EDUP6023 T3 Google Sites 20 Oktober** dianggap belum dihantar kerana status asal menyatakan *NOT SUBMITTED*, walaupun catatan menggunakan tanda ✓.

## Privasi dan had

Maklumat disimpan dalam storan setempat pelayar (`localStorage`) dan tidak dihantar ke mana-mana pelayan oleh kod aplikasi. Sandaran JSON boleh dipindahkan secara manual ke peranti lain. Aplikasi ini **tidak** menyediakan penyelarasan berbilang peranti, pemberitahuan automatik semasa aplikasi ditutup, atau fail APK/IPA natif.
