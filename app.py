from flask import Flask, request, jsonify
import subprocess
import os

app = Flask(__name__)

DOWNLOADS_DIR = "downloads"
os.makedirs(DOWNLOADS_DIR, exist_ok=True)

@app.route("/download", methods=["POST"])
def download():
    data = request.json
    url = data.get("url")

    if not url:
        return jsonify({"error": "No URL provided"}), 400

    try:
        subprocess.run(
            [
                "yt-dlp",
                "-f", "bestaudio/best",
                "-o", f"{DOWNLOADS_DIR}/%(title)s.%(ext)s",
                url
            ],
            check=True
        )
        return jsonify({"status": "Download complete"})
    except subprocess.CalledProcessError:
        return jsonify({"error": "Download failed"}), 500


if __name__ == "__main__":
    app.run(port=5000, debug=True)
  
