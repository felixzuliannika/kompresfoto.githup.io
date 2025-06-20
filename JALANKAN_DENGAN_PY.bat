@echo off
title Web Kompres Foto dengan Py Launcher

echo ========================================
echo    WEB KOMPRES FOTO - PY LAUNCHER
echo ========================================
echo.

echo Mencoba menjalankan Python dengan py launcher...
py --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python tidak ditemukan!
    echo Silakan install Python terlebih dahulu.
    pause
    exit /b 1
)

echo Python ditemukan dengan py launcher!
py --version
echo.

echo Menginstall dependensi...
echo.

echo 1. Upgrade pip...
py -m pip install --upgrade pip

echo.
echo 2. Install Flask...
py -m pip install Flask

echo.
echo 3. Install Pillow...
py -m pip install Pillow

echo.
echo 4. Install Werkzeug...
py -m pip install Werkzeug

echo.
echo Dependensi berhasil diinstall!
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