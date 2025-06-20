# 🖼️ Web Kompres Foto

Aplikasi web sederhana untuk mengompres foto menggunakan Python Flask dan HTML. Aplikasi ini memungkinkan pengguna untuk mengupload foto dan mengompresnya dengan pengaturan kualitas yang dapat disesuaikan.

## ✨ Fitur

- **Upload Foto**: Drag & drop atau klik untuk memilih file
- **Format yang Didukung**: JPG, PNG, GIF, BMP, WebP
- **Pengaturan Kompresi**:
  - Kualitas kompresi (10-100%)
  - Ukuran maksimum (lebar x tinggi)
- **Antarmuka Modern**: Desain responsif dan user-friendly
- **Download Otomatis**: Download hasil kompresi langsung
- **Pembersihan Otomatis**: File sementara dibersihkan secara otomatis

## 🚀 Cara Menjalankan

### 1. Install Dependensi

```bash
pip install -r requirements.txt
```

### 2. Jalankan Aplikasi

```bash
python app.py
```

### 3. Buka Browser

Buka browser dan kunjungi: `http://localhost:5000`

## 📁 Struktur Proyek

```
kompress/
├── app.py                 # File utama aplikasi Flask
├── requirements.txt       # Dependensi Python
├── README.md             # Dokumentasi
├── templates/
│   └── index.html        # Template HTML
├── uploads/              # Folder untuk file sementara (auto-created)
└── compressed/           # Folder untuk hasil kompresi (auto-created)
```

## 🛠️ Teknologi yang Digunakan

- **Backend**: Python Flask
- **Image Processing**: Pillow (PIL)
- **Frontend**: HTML, CSS, JavaScript
- **Styling**: CSS3 dengan gradient dan animasi

## 📱 Responsif

Aplikasi ini responsif dan dapat digunakan di berbagai perangkat:

- Desktop
- Tablet
- Mobile

## 🔧 Pengaturan

### Maksimum Ukuran File

Default: 16MB (dapat diubah di `app.py`)

### Format yang Didukung

- JPG/JPEG
- PNG
- GIF
- BMP
- WebP

### Pengaturan Default Kompresi

- Kualitas: 85%
- Ukuran maksimum: 800x800 pixel

## 🧹 Pembersihan Otomatis

Aplikasi secara otomatis membersihkan file sementara setiap 5 menit untuk menghemat ruang penyimpanan.

## 📝 Lisensi

Proyek ini dibuat untuk tujuan pembelajaran dan penggunaan pribadi.

## 🤝 Kontribusi

Silakan buat pull request atau issue jika ingin berkontribusi pada proyek ini.

---

**Dibuat dengan ❤️ menggunakan Python dan Flask**
