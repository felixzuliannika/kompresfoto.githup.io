@echo off
echo ========================================
echo    Web Kompres Foto - Python Checker
echo ========================================
echo.

echo Mencoba berbagai cara menjalankan Python...
echo.

echo 1. Mencoba 'python'...
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Python ditemukan dengan 'python'
    goto :run_app
)

echo 2. Mencoba 'python3'...
python3 --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Python ditemukan dengan 'python3'
    set PYTHON_CMD=python3
    goto :run_app
)

echo 3. Mencoba 'py'...
py --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Python ditemukan dengan 'py'
    set PYTHON_CMD=py
    goto :run_app
)

echo 4. Mencoba mencari Python di PATH...
where python >nul 2>&1
if %errorlevel% equ 0 (
    echo Python ditemukan di PATH
    goto :run_app
)

echo.
echo ========================================
echo    Python tidak ditemukan!
echo ========================================
echo.
echo Silakan install Python terlebih dahulu:
echo.
echo METODE 1 - Microsoft Store (Paling Mudah):
echo 1. Buka Microsoft Store
echo 2. Cari "Python"
echo 3. Install "Python 3.11" atau versi terbaru
echo.
echo METODE 2 - Download Manual:
echo 1. Kunjungi https://www.python.org/downloads/
echo 2. Download Python versi terbaru
echo 3. Install dengan opsi "Add Python to PATH"
echo.
echo METODE 3 - Menggunakan Anaconda:
echo 1. Download Anaconda dari https://www.anaconda.com/
echo 2. Install Anaconda
echo 3. Gunakan Anaconda Prompt
echo.
pause
exit /b 1

:run_app
echo.
echo Python ditemukan! Mencoba install dependensi...
echo.

if defined PYTHON_CMD (
    %PYTHON_CMD% -m pip install -r requirements.txt
) else (
    python -m pip install -r requirements.txt
)

if %errorlevel% neq 0 (
    echo.
    echo Gagal menginstall dependensi!
    echo Coba jalankan sebagai Administrator
    echo.
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

if defined PYTHON_CMD (
    %PYTHON_CMD% app.py
) else (
    python app.py
)

pause 