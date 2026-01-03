# Simple YouTube Downloader

A **super-simple YouTube downloader** built with **Python (Flask) backend**, `yt-dlp`, and a minimal **HTML/CSS/JS frontend**. Focused on simplicity, lightweight design, and a clean dark theme.

---

## Table of Contents

- [Demo](#demo)  
- [Features](#features)  
- [Installation](#installation)  
- [Usage](#usage)  
- [Frontend Overview](#frontend-overview)  
- [Backend Overview](#backend-overview)  
- [Comparison](#comparison)  
- [Effects & Boxes](#effects--boxes)  
- [License](#license)  

---

## Demo

⚠️ This project runs locally on [http://localhost:5000](http://localhost:5000).  
Just open the page, paste a YouTube URL, and click **Download**.

---

## Features

- ✅ Super simple dark-themed UI  
- ✅ Paste a YouTube URL and download directly  
- ✅ Minimal dependencies  
- ✅ Runs locally (no ads, no tracking)  

---

## Installation

You need **Python 3.10+** installed.

```bash
# Clone repository
git clone https://github.com/yourusername/simple-ytdl-dark.git
cd simple-ytdl-dark

# Create virtual environment
python -m venv venv

# Activate it
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
````

`requirements.txt`:

```
flask
yt-dlp
```

---

## Usage

```bash
# Run backend
python app.py
```

1. Open your browser and go to [http://localhost:5000](http://localhost:5000)
2. Paste your YouTube URL
3. Click **Download**

Downloads are saved in the `downloads/` folder.

---

## Frontend Overview

**HTML (`index.html`)**

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>YouTube Downloader</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
  <h1>Simple YouTube Downloader</h1>
  <input type="text" id="url" placeholder="Paste YouTube URL">
  <button id="download">Download</button>
  <p id="status"></p>
</div>
<script src="script.js"></script>
</body>
</html>
```

**CSS (`style.css`)**

```css
body {
    background-color: #121212;
    color: #eee;
    font-family: Arial, sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.container {
    text-align: center;
    background-color: #1e1e1e;
    padding: 2rem;
    border-radius: 12px;
    box-shadow: 0 0 20px rgba(0,0,0,0.7);
}

input {
    width: 80%;
    padding: 0.5rem;
    margin: 1rem 0;
    border-radius: 6px;
    border: none;
    outline: none;
}

button {
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 6px;
    background-color: #ff5c5c;
    color: #fff;
    cursor: pointer;
}

button:hover {
    background-color: #ff3b3b;
}
```

**JS (`script.js`)**

```js
document.getElementById("download").addEventListener("click", async () => {
    const url = document.getElementById("url").value;
    const status = document.getElementById("status");
    status.textContent = "Downloading...";
    
    const res = await fetch("/download", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ url })
    });

    const data = await res.json();
    if(data.success){
        status.innerHTML = `Download complete: <a href="${data.file}" target="_blank">Click to open</a>`;
    } else {
        status.textContent = `Error: ${data.error}`;
    }
});
```

---

## Backend Overview

**Python Flask backend (`app.py`)**

```python
from flask import Flask, request, jsonify
import yt_dlp
import os

app = Flask(__name__)
DOWNLOAD_FOLDER = "downloads"
os.makedirs(DOWNLOAD_FOLDER, exist_ok=True)

@app.route("/download", methods=["POST"])
def download():
    data = request.get_json()
    url = data.get("url")
    if not url:
        return jsonify({"success": False, "error": "No URL provided"})

    ydl_opts = {
        "outtmpl": f"{DOWNLOAD_FOLDER}/%(title)s.%(ext)s",
        "format": "bestvideo+bestaudio/best",
    }

    try:
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info = ydl.extract_info(url, download=True)
            filename = ydl.prepare_filename(info)
        return jsonify({"success": True, "file": filename})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)})

if __name__ == "__main__":
    app.run(debug=True)
```

---

## Comparison

| Feature        | This Project    | Other Downloaders   |
| -------------- | --------------- | ------------------- |
| Dark Theme     | ✅ Yes           | ❌ Usually light     |
| Local Server   | ✅ Yes           | ❌ Often online only |
| Lightweight    | ✅ Minimal deps  | ❌ Heavy installers  |
| Easy to Modify | ✅ Simple JS/CSS | ❌ Complicated code  |
| Privacy        | ✅ Fully local   | ❌ May track users   |

---

## Effects & Boxes

CSS examples for info/success/error boxes:

```css
.info-box {
    background: #222;
    border-left: 4px solid #ff5c5c;
    padding: 1rem;
    margin: 1rem 0;
}

.success-box {
    background: #1a3d1a;
    border-left: 4px solid #5cb85c;
    padding: 1rem;
    margin: 1rem 0;
}

.error-box {
    background: #3d1a1a;
    border-left: 4px solid #d9534f;
    padding: 1rem;
    margin: 1rem 0;
}
```

---

## License

MIT License © 2026

Free to use, modify, and share.

Made with ❤️ by **Hevji**
