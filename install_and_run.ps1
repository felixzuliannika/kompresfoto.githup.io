Write-Host "========================================" -ForegroundColor Cyan
Write-Host "    Web Kompres Foto - Installer" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Memeriksa Python..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version 2>&1
    Write-Host "Python ditemukan: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "Python tidak ditemukan!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Silakan install Python terlebih dahulu:" -ForegroundColor Yellow
    Write-Host "1. Kunjungi https://www.python.org/downloads/" -ForegroundColor White
    Write-Host "2. Download Python versi terbaru" -ForegroundColor White
    Write-Host "3. Install dengan opsi 'Add Python to PATH'" -ForegroundColor White
    Write-Host ""
    Read-Host "Tekan Enter untuk keluar"
    exit 1
}

Write-Host ""
Write-Host "Menginstall dependensi..." -ForegroundColor Yellow
try {
    python -m pip install -r requirements.txt
    Write-Host "Dependensi berhasil diinstall!" -ForegroundColor Green
} catch {
    Write-Host "Gagal menginstall dependensi!" -ForegroundColor Red
    Read-Host "Tekan Enter untuk keluar"
    exit 1
}

Write-Host ""
Write-Host "Menjalankan aplikasi..." -ForegroundColor Yellow
Write-Host "Buka browser dan kunjungi: http://localhost:5000" -ForegroundColor Cyan
Write-Host "Tekan Ctrl+C untuk menghentikan aplikasi" -ForegroundColor Yellow
Write-Host ""

try {
    python app.py
} catch {
    Write-Host "Aplikasi dihentikan." -ForegroundColor Yellow
}

Read-Host "Tekan Enter untuk keluar" 