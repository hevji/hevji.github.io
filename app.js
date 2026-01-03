document.getElementById("download").addEventListener("click", async () => {
    const url = document.getElementById("url").value;
    const status = document.getElementById("status");
    status.textContent = "Downloading...";

    try {
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
    } catch (err) {
        status.textContent = `Error: ${err.message}`;
    }
});
