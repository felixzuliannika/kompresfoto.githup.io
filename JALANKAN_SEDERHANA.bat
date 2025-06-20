@echo off
title Web Kompres Foto - Sederhana

echo ========================================
echo    WEB KOMPRES FOTO - SEDERHANA
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

echo Menginstall dependensi...
py -m pip install Flask Pillow Werkzeug

echo.
echo Menjalankan aplikasi...
echo.
echo Buka browser dan kunjungi:
echo http://localhost:5000
echo.
echo Tekan Ctrl+C untuk menghentikan aplikasi
echo.

py app_simple.py

echo.
echo Aplikasi dihentikan.
pause 