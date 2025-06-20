@echo off
echo ========================================
echo    Web Kompres Foto - Installer
echo ========================================
echo.

echo Memeriksa Python...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python tidak ditemukan!
    echo.
    echo Silakan install Python terlebih dahulu:
    echo 1. Kunjungi https://www.python.org/downloads/
    echo 2. Download Python versi terbaru
    echo 3. Install dengan opsi "Add Python to PATH"
    echo.
    pause
    exit /b 1
)

echo Python ditemukan!
echo.

echo Menginstall dependensi...
python -m pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo Gagal menginstall dependensi!
    pause
    exit /b 1
)

echo.
echo Dependensi berhasil diinstall!
echo.
echo Menjalankan aplikasi...
echo Buka browser dan kunjungi: http://localhost:5000
echo Tekan Ctrl+C untuk menghentikan aplikasi
echo.

python app.py

pause 