from flask import Flask, render_template, request, send_file, jsonify
from PIL import Image
import os
import io
import uuid
from werkzeug.utils import secure_filename

app = Flask(__name__)
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 16MB max file size
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['COMPRESSED_FOLDER'] = 'compressed'

# Buat direktori jika belum ada
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)
os.makedirs(app.config['COMPRESSED_FOLDER'], exist_ok=True)

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif', 'bmp', 'webp'}

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def compress_image(image_path, quality=85, max_size=(800, 800)):
    """Kompres gambar dengan kualitas dan ukuran yang dapat disesuaikan"""
    try:
        with Image.open(image_path) as img:
            # Konversi ke RGB jika mode bukan RGB
            if img.mode in ('RGBA', 'LA', 'P'):
                # Buat background putih untuk gambar transparan
                background = Image.new('RGB', img.size, (255, 255, 255))
                if img.mode == 'P':
                    img = img.convert('RGBA')
                background.paste(img, mask=img.split()[-1] if img.mode == 'RGBA' else None)
                img = background
            elif img.mode != 'RGB':
                img = img.convert('RGB')
            
            # Resize jika ukuran terlalu besar
            if img.size[0] > max_size[0] or img.size[1] > max_size[1]:
                img.thumbnail(max_size, Image.Resampling.LANCZOS)
            
            # Simpan dengan kompresi
            output = io.BytesIO()
            img.save(output, format='JPEG', quality=quality, optimize=True)
            output.seek(0)
            return output
    except Exception as e:
        print(f"Error compressing image: {e}")
        return None

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/compress', methods=['POST'])
def compress():
    if 'file' not in request.files:
        return jsonify({'error': 'Tidak ada file yang dipilih'}), 400
    
    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'Tidak ada file yang dipilih'}), 400
    
    if not allowed_file(file.filename):
        return jsonify({'error': 'Format file tidak didukung'}), 400
    
    # Ambil parameter kompresi
    quality = int(request.form.get('quality', 85))
    max_width = int(request.form.get('max_width', 800))
    max_height = int(request.form.get('max_height', 800))
    
    try:
        # Simpan file sementara
        filename = secure_filename(file.filename)
        unique_filename = f"{uuid.uuid4().hex}_{filename}"
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], unique_filename)
        file.save(filepath)
        
        # Kompres gambar
        compressed = compress_image(filepath, quality, (max_width, max_height))
        
        if compressed is None:
            return jsonify({'error': 'Gagal mengompres gambar'}), 500
        
        # Simpan hasil kompresi
        compressed_filename = f"compressed_{unique_filename}"
        compressed_path = os.path.join(app.config['COMPRESSED_FOLDER'], compressed_filename)
        
        with open(compressed_path, 'wb') as f:
            f.write(compressed.getvalue())
        
        # Hapus file asli
        os.remove(filepath)
        
        return jsonify({
            'success': True,
            'filename': compressed_filename,
            'message': 'Gambar berhasil dikompres!'
        })
        
    except Exception as e:
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
    """Bersihkan file yang sudah tidak digunakan"""
    try:
        for folder in [app.config['UPLOAD_FOLDER'], app.config['COMPRESSED_FOLDER']]:
            for filename in os.listdir(folder):
                filepath = os.path.join(folder, filename)
                if os.path.isfile(filepath):
                    os.remove(filepath)
        return jsonify({'message': 'Pembersihan berhasil'})
    except Exception as e:
        return jsonify({'error': f'Gagal membersihkan: {str(e)}'}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000) 