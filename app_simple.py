#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Web Kompres Foto - Versi Sederhana
Aplikasi Flask untuk kompres foto dengan error handling yang lebih baik
"""

import os
import sys
import io
import uuid
from pathlib import Path

# Cek Python version
if sys.version_info < (3, 7):
    print("❌ Error: Python 3.7 atau lebih baru diperlukan!")
    print(f"   Versi Python Anda: {sys.version}")
    input("Tekan Enter untuk keluar...")
    sys.exit(1)

try:
    from flask import Flask, render_template, request, send_file, jsonify
    from flask_cors import CORS
except ImportError:
    print("❌ Error: Flask tidak terinstall!")
    print("   Jalankan: pip install Flask flask-cors")
    input("Tekan Enter untuk keluar...")
    sys.exit(1)

try:
    from PIL import Image
except ImportError:
    print("❌ Error: Pillow tidak terinstall!")
    print("   Jalankan: pip install Pillow")
    input("Tekan Enter untuk keluar...")
    sys.exit(1)

try:
    from werkzeug.utils import secure_filename
except ImportError:
    print("❌ Error: Werkzeug tidak terinstall!")
    print("   Jalankan: pip install Werkzeug")
    input("Tekan Enter untuk keluar...")
    sys.exit(1)

# Inisialisasi Flask
app = Flask(__name__)
CORS(app)  # Enable CORS untuk semua route

app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 16MB
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['COMPRESSED_FOLDER'] = 'compressed'

# Buat direktori jika belum ada
Path(app.config['UPLOAD_FOLDER']).mkdir(exist_ok=True)
Path(app.config['COMPRESSED_FOLDER']).mkdir(exist_ok=True)

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif', 'bmp', 'webp'}

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def compress_image(image_path):
    """Kompres gambar dengan pengaturan default yang optimal"""
    try:
        with Image.open(image_path) as img:
            # Konversi ke RGB jika perlu
            if img.mode in ('RGBA', 'LA', 'P'):
                background = Image.new('RGB', img.size, (255, 255, 255))
                if img.mode == 'P':
                    img = img.convert('RGBA')
                background.paste(img, mask=img.split()[-1] if img.mode == 'RGBA' else None)
                img = background
            elif img.mode != 'RGB':
                img = img.convert('RGB')
            
            # Resize jika terlalu besar (maksimum 800x800)
            max_size = (800, 800)
            if img.size[0] > max_size[0] or img.size[1] > max_size[1]:
                img.thumbnail(max_size, Image.Resampling.LANCZOS)
            
            # Simpan dengan kompresi optimal (85% quality)
            output = io.BytesIO()
            img.save(output, format='JPEG', quality=85, optimize=True)
            output.seek(0)
            return output
    except Exception as e:
        print(f"❌ Error kompresi: {e}")
        return None

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/compress', methods=['POST'])
def compress():
    try:
        print("📥 Request kompresi diterima")
        
        if 'file' not in request.files:
            print("❌ Tidak ada file dalam request")
            return jsonify({'error': 'Tidak ada file yang dipilih'}), 400
        
        file = request.files['file']
        if file.filename == '':
            print("❌ Nama file kosong")
            return jsonify({'error': 'Tidak ada file yang dipilih'}), 400
        
        if not allowed_file(file.filename):
            print(f"❌ Format file tidak didukung: {file.filename}")
            return jsonify({'error': 'Format file tidak didukung'}), 400
        
        print(f"✅ File diterima: {file.filename}")
        
        # Simpan file sementara
        filename = secure_filename(file.filename)
        unique_filename = f"{uuid.uuid4().hex}_{filename}"
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], unique_filename)
        file.save(filepath)
        
        print(f"💾 File disimpan: {filepath}")
        
        # Kompres gambar dengan pengaturan default
        compressed = compress_image(filepath)
        
        if compressed is None:
            print("❌ Gagal mengompres gambar")
            return jsonify({'error': 'Gagal mengompres gambar'}), 500
        
        # Simpan hasil kompresi
        compressed_filename = f"compressed_{unique_filename}"
        compressed_path = os.path.join(app.config['COMPRESSED_FOLDER'], compressed_filename)
        
        with open(compressed_path, 'wb') as f:
            f.write(compressed.getvalue())
        
        # Hapus file asli
        os.remove(filepath)
        
        print(f"✅ Kompresi berhasil: {compressed_filename}")
        
        return jsonify({
            'success': True,
            'filename': compressed_filename,
            'message': 'Gambar berhasil dikompres!'
        })
        
    except Exception as e:
        print(f"❌ Error di compress: {e}")
        return jsonify({'error': f'Terjadi kesalahan: {str(e)}'}), 500

@app.route('/download/<filename>')
def download(filename):
    try:
        return send_file(
            os.path.join(app.config['COMPRESSED_FOLDER'], filename),
            as_attachment=True,
            download_name=filename.replace('compressed_', '')
        )
    except Exception as e:
        return jsonify({'error': f'File tidak ditemukan: {str(e)}'}), 404

@app.route('/cleanup', methods=['POST'])
def cleanup():
    """Bersihkan file sementara"""
    try:
        for folder in [app.config['UPLOAD_FOLDER'], app.config['COMPRESSED_FOLDER']]:
            for filename in os.listdir(folder):
                filepath = os.path.join(folder, filename)
                if os.path.isfile(filepath):
                    os.remove(filepath)
        return jsonify({'message': 'Pembersihan berhasil'})
    except Exception as e:
        return jsonify({'error': f'Gagal membersihkan: {str(e)}'}), 500

@app.route('/test')
def test():
    """Route test untuk memastikan server berjalan"""
    return jsonify({'status': 'OK', 'message': 'Server berjalan dengan baik'})

def main():
    """Fungsi utama dengan error handling"""
    print("=" * 50)
    print("    🖼️ Web Kompres Foto")
    print("=" * 50)
    print()
    
    try:
        print("✅ Python version:", sys.version.split()[0])
        print("✅ Flask terinstall")
        print("✅ Pillow terinstall")
        print("✅ Werkzeug terinstall")
        print()
        
        print("🚀 Menjalankan aplikasi...")
        print("📱 Buka browser dan kunjungi: http://localhost:5000")
        print("🧪 Test server: http://localhost:5000/test")
        print("⏹️  Tekan Ctrl+C untuk menghentikan")
        print()
        
        app.run(debug=True, host='0.0.0.0', port=5000)
        
    except KeyboardInterrupt:
        print("\n👋 Aplikasi dihentikan oleh pengguna")
    except Exception as e:
        print(f"\n❌ Error menjalankan aplikasi: {e}")
        input("Tekan Enter untuk keluar...")

if __name__ == '__main__':
    main() 