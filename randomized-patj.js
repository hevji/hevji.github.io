(() => {
  const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*";
  const blockLength = 4;
  const intervalMs = 1;

  function randomBlock() {
    let out = "";
    for (let i = 0; i < blockLength; i++) {
      out += chars[Math.floor(Math.random() * chars.length)];
    }
    return out;
  }

  function generatePath() {
    return `/${randomBlock()}-${randomBlock()}`;
  }

  setInterval(() => {
    try {
      history.replaceState(null, "", generatePath());
    } catch (_) {}
  }, intervalMs);
})();
