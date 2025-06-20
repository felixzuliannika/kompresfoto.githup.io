# 🐍 Cara Install Python di Windows

## ⚠️ Masalah: Python tidak ditemukan

Jika Anda mendapat error "Python was not found", ikuti langkah-langkah berikut:

## 📥 Metode 1: Microsoft Store (Paling Mudah)

1. **Buka Microsoft Store**

   - Tekan `Windows + S`
   - Ketik "Microsoft Store"
   - Klik "Microsoft Store"

2. **Cari Python**

   - Di search bar, ketik "Python"
   - Pilih "Python 3.11" atau versi terbaru
   - Klik "Get" atau "Install"

3. **Tunggu instalasi selesai**
   - Proses ini akan otomatis menambahkan Python ke PATH

## 📥 Metode 2: Download Manual

1. **Kunjungi website resmi**

   - Buka: https://www.python.org/downloads/
   - Klik tombol kuning "Download Python 3.x.x"

2. **Jalankan installer**

   - **PENTING**: Centang ✅ "Add Python to PATH"
   - Klik "Install Now"
   - Tunggu proses selesai

3. **Verifikasi instalasi**
   - Buka Command Prompt baru
   - Ketik: `python --version`
   - Harus muncul versi Python

## 🔧 Setelah Python Terinstall

1. **Restart Command Prompt/PowerShell**
2. **Jalankan aplikasi kompres foto:**
   ```bash
   cd C:\Users\asus_\kompress
   run_with_python_web.bat
   ```

## ❓ Troubleshooting

### Jika masih "Python not found":

- Restart komputer
- Coba buka Command Prompt sebagai Administrator
- Cek apakah Python ada di: `C:\Users\[username]\AppData\Local\Programs\Python`

### Jika error saat install dependensi:

- Jalankan Command Prompt sebagai Administrator
- Coba: `python -m pip install --upgrade pip`
- Lalu: `python -m pip install -r requirements.txt`

### Jika aplikasi tidak bisa diakses:

- Pastikan tidak ada aplikasi lain di port 5000
- Coba akses: `http://127.0.0.1:5000`
- Matikan firewall sementara

## 📞 Bantuan

Jika masih bermasalah:

1. Screenshot error yang muncul
2. Kirimkan output dari `python --version`
3. Cek apakah ada antivirus yang memblokir

---

**Catatan**: Python 3.7 atau lebih baru diperlukan untuk aplikasi ini.
