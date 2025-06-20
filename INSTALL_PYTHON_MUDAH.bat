@echo off
title Install Python dan Jalankan Aplikasi

echo ========================================
echo    INSTALL PYTHON DAN JALANKAN APLIKASI
echo ========================================
echo.

echo 1. Mencoba menjalankan Python...
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Python sudah terinstall!
    goto :run_app
)

echo Python belum terinstall.
echo.
echo PILIH METODE INSTALL:
echo.
echo 1. Microsoft Store (Paling Mudah)
echo 2. Download Manual
echo 3. Keluar
echo.
set /p choice="Pilih (1-3): "

if "%choice%"=="1" goto :microsoft_store
if "%choice%"=="2" goto :download_manual
if "%choice%"=="3" goto :exit
goto :exit

:microsoft_store
echo.
echo METODE 1: Microsoft Store
echo.
echo 1. Tekan Windows + S
echo 2. Ketik "Microsoft Store"
echo 3. Cari "Python"
echo 4. Install "Python 3.11" atau versi terbaru
echo 5. Restart Command Prompt
echo 6. Jalankan script ini lagi
echo.
pause
goto :exit

:download_manual
echo.
echo METODE 2: Download Manual
echo.
echo 1. Buka: https://www.python.org/downloads/
echo 2. Klik "Download Python 3.x.x"
echo 3. Jalankan installer
echo 4. PENTING: Centang "Add Python to PATH"
echo 5. Klik "Install Now"
echo 6. Restart Command Prompt
echo 7. Jalankan script ini lagi
echo.
pause
goto :exit

:run_app
echo.
echo Python ditemukan! Menginstall dependensi...
echo.

python -m pip install --upgrade pip
python -m pip install Flask Pillow Werkzeug

if %errorlevel% neq 0 (
    echo.
    echo Gagal install dependensi!
    echo Coba jalankan sebagai Administrator
    echo.
    pause
    goto :exit
)

echo.
echo Dependensi berhasil diinstall!
echo.
echo Menjalankan aplikasi...
echo Buka browser: http://localhost:5000
echo.

python app_simple.py

:exit
echo.
echo Selesai.
pause 