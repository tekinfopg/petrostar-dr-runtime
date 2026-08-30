# Petrostar DR — image runtime

Meniru runtime VM produksi Petrostar: Ubuntu 22.04 + Apache 2.4 +
PHP 8.1-FPM & 8.2-FPM lewat `proxy_fcgi`.

Dibuat karena Dockerfile di repo aplikasi menyasar **PHP 7.0.33 / 7.2.34**,
sedangkan produksi berjalan di **8.1.28 / 8.2.17** — jadi tidak terpakai.

Daftar ekstensi diambil langsung dari `php -m` di server produksi.

Kode aplikasi **tidak dibakar** ke image; dipasang lewat volume
`petrostar-dr-kode` pada `/var/www/html`, supaya image tetap kecil dan
kode bisa diperbarui tanpa build ulang.

## Dipakai oleh
Stack Portainer di environment `PG-PETROPORT-2`, dibangun langsung dari
repo ini supaya prosesnya berjalan di sisi server — tidak terganggu kalau
VPN operator putus di tengah build.
