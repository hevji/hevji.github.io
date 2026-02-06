if (window.location.pathname.endsWith('.html')) {
  const newPath = window.location.pathname.slice(0, -5);
  window.history.replaceState({}, '', newPath + window.location.search + window.location.hash);
}
