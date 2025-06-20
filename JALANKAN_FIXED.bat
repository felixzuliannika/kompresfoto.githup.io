@echo off
title Web Kompres Foto - Fixed Version

echo ========================================
echo    WEB KOMPRES FOTO - FIXED VERSION
echo ========================================
echo.

echo Mencoba menjalankan Python...
py --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python tidak ditemukan!
    echo Silakan install Python terlebih dahulu.
    pause
    exit /b 1
)

echo Python ditemukan!
py --version
echo.

echo Menginstall semua dependensi...
echo.

echo 1. Flask...
py -m pip install Flask

echo.
echo 2. Pillow...
py -m pip install Pillow

echo.
echo 3. Werkzeug...
py -m pip install Werkzeug

echo.
echo 4. Flask-CORS...
py -m pip install flask-cors

echo.
echo Dependensi berhasil diinstall!
echo.

echo Menjalankan aplikasi dengan debug mode...
echo.
echo Buka browser dan kunjungi:
echo http://localhost:5000
echo.
echo Test server: http://localhost:5000/test
echo.
echo Tekan Ctrl+C untuk menghentikan aplikasi
echo.

py app_simple.py

echo.
echo Aplikasi dihentikan.
pause 