async function download() {
  const status = document.getElementById("status");
  status.textContent = "⏳ Downloading…";

  const payload = {
    mode: document.getElementById("mode").value,
    input: document.getElementById("input").value,
    format: document.getElementById("format").value,
    duration: document.getElementById("duration").value || null
  };

  try {
    const res = await fetch("http://localhost:8000/download", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload)
    });

    if (!res.ok) throw new Error("Download failed");

    status.textContent = "✅ Done!";
  } catch (e) {
    status.textContent = "❌ Error";
  }
}
