// token.js
const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789~^&!@#$%*';

// Generate a random token like XXXX-XXXX
function generateToken() {
    const part1 = Array.from({length:4}, ()=>chars[Math.floor(Math.random()*chars.length)]).join('');
    const part2 = Array.from({length:4}, ()=>chars[Math.floor(Math.random()*chars.length)]).join('');
    return `${part1}-${part2}`;
}

// Save token to sessionStorage
function saveToken(token) {
    sessionStorage.setItem('oneTimeToken', token);
}

// Validate token from URL
function validateToken(urlToken) {
    const storedToken = sessionStorage.getItem('oneTimeToken');
    return storedToken && urlToken === storedToken;
}

// Clear token (expire it)
function expireToken() {
    sessionStorage.removeItem('oneTimeToken');
}

// Randomize URL for cosmetic effect
function randomizeURL(page) {
    const randomPart = generateToken();
    history.replaceState(null, '', `loading.html?page=${page}/${randomPart}`);
}
