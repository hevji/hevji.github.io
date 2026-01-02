from fastapi import FastAPI
from pydantic import BaseModel
import subprocess
import requests
import json

app = FastAPI(title="Ad-Free Music Downloader")

class DownloadRequest(BaseModel):
    mode: str            # spotify | ytmusic
    input: str           # spotify link OR search query
    format: str          # mp3 | flac | opus
    duration: int | None # seconds (optional)

# -------------------------
# Spotify metadata
# -------------------------
def get_spotify_metadata(url: str):
    r = requests.get(
        "https://open.spotify.com/oembed",
        params={"url": url},
        timeout=10
    )
    r.raise_for_status()

    title = r.json()["title"]
    song, artist = title.split("–", 1)
    return song.strip(), artist.strip()

# -------------------------
# yt-dlp logic
# -------------------------
def run_ytdlp(query, audio_format, duration):
    search = f"ytmusicsearch5:{query}"

    match_filter = []
    if duration:
        match_filter = [
            "--match-filter",
            f"duration >= {duration-5} & duration <= {duration+5}"
        ]

    cmd = [
        "yt-dlp",
        search,
        "-x",
        "--audio-format", audio_format,
        "--audio-quality", "0",
        "--embed-metadata",
        "--embed-thumbnail",
        "-o", "%(artist)s - %(title)s.%(ext)s",
        *match_filter
    ]

    subprocess.run(cmd, check=True)

# -------------------------
# API endpoint
# -------------------------
@app.post("/download")
def download(req: DownloadRequest):
    if req.mode == "spotify":
        song, artist = get_spotify_metadata(req.input)
        query = f"{song} {artist}"
    else:
        query = req.input

    run_ytdlp(query, req.format, req.duration)
    return {"status": "ok", "query": query}
