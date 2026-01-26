# 🟩 MC Loader — Browser Minecraft via Eaglercraft

A lightweight web-based Minecraft Loader that runs Minecraft directly in your browser using Eaglercraft.
No Java installation, no launcher, no downloads — just open the site and play.

This project provides a clean loader interface to select versions, manage servers, and launch Eaglercraft instantly.

---

## ✨ Features

- Run Minecraft fully in the browser (powered by Eaglercraft)
- One-click launch — no Java or official launcher required
- Version selector (1.5.2 / 1.8.8 supported by Eaglercraft)
- Multiplayer server list & quick connect
- Local saves stored in browser storage
- Customizable UI / theming
- Optional offline support with service workers

---

## 🧩 What is Eaglercraft?

Eaglercraft is a web-based port of Minecraft that runs using WebAssembly + WebGL.
It allows Minecraft Java Edition to run inside modern browsers without installing Java.

This loader acts only as a frontend launcher for Eaglercraft builds.

---

## ⚠️ Disclaimer

- Not affiliated with Mojang, Microsoft, or Minecraft
- Not an official Minecraft product
- Intended for educational and personal use only

You must own a legitimate copy of Minecraft to comply with Mojang’s EULA.

---

## 📦 Project Structure

mc-loader/
├── public/
│   ├── index.html
│   ├── css/
│   │   └── style.css
│   ├── js/
│   │   ├── loader.js
│   │   └── versions.js
│   └── eagler/
│       ├── 1.5.2/
│       └── 1.8.8/
├── servers.json
├── README.md
└── LICENSE

---

## 🚀 Getting Started

Clone the repository:

git clone https://github.com/yourname/mc-loader.git
cd mc-loader

---

## 🎮 Usage

1. Open the loader in your browser
2. Select a Minecraft version
3. Choose singleplayer or multiplayer
4. Click Launch
5. Minecraft opens inside the page

---

## 🛡 Security Notes

- Saves use IndexedDB / LocalStorage
- Multiplayer uses secure WebSocket connections
- No Mojang authentication (offline mode only)

---

## 📜 License

This loader is licensed under the MIT License.
Eaglercraft is licensed separately by its authors.

---

Enjoy Minecraft in your browser!
