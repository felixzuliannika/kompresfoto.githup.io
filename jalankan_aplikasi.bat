@echo off
chcp 65001 >nul
title Web Kompres Foto

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    🖼️ WEB KOMPRES FOTO                      ║
echo ║                                                              ║
echo ║  Aplikasi web untuk kompres foto dengan Python dan Flask    ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

echo 🔍 Memeriksa Python...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ❌ Python tidak ditemukan!
    echo.
    echo 📋 Silakan install Python terlebih dahulu:
    echo.
    echo 🛒 METODE 1 - Microsoft Store (Paling Mudah):
    echo    1. Buka Microsoft Store
    echo    2. Cari "Python"
    echo    3. Install "Python 3.11" atau versi terbaru
    echo.
    echo 🌐 METODE 2 - Download Manual:
    echo    1. Kunjungi https://www.python.org/downloads/
    echo    2. Download Python versi terbaru
    echo    3. Install dengan opsi "Add Python to PATH"
    echo.
    echo 📁 File bantuan tersedia:
    echo    - CARA_INSTALL_PYTHON.md
    echo    - SOLUSI_PYTHON.txt
    echo.
    pause
    exit /b 1
)

echo ✅ Python ditemukan!
python --version
echo.

echo 📦 Menginstall dependensi...
python -m pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo.
    echo ❌ Gagal menginstall dependensi!
    echo.
    echo 💡 Coba jalankan sebagai Administrator:
    echo    1. Klik kanan pada file ini
    echo    2. Pilih "Run as administrator"
    echo.
    pause
    exit /b 1
)

echo.
echo ✅ Dependensi berhasil diinstall!
echo.

echo 🚀 Menjalankan aplikasi...
echo.
echo 📱 Buka browser dan kunjungi:
echo    🌐 http://localhost:5000
echo    🔗 http://127.0.0.1:5000
echo.
echo ⏹️  Tekan Ctrl+C untuk menghentikan aplikasi
echo.

python app_simple.py

echo.
echo 👋 Aplikasi dihentikan
pause 