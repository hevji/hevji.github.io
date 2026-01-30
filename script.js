const input = document.getElementById("input");
const output = document.getElementById("output");
const rotSlider = document.getElementById("rot");
const rotValue = document.getElementById("rotValue");

function rotDecode(text, shift) {
  return text.replace(/[a-z]/gi, char => {
    const base = char <= "Z" ? 65 : 97;
    return String.fromCharCode(
      ((char.charCodeAt(0) - base - shift + 26) % 26) + base
    );
  });
}

function update() {
  const rot = parseInt(rotSlider.value);
  rotValue.textContent = rot;

  output.textContent = rotDecode(input.value, rot);
}

input.addEventListener("input", update);
rotSlider.addEventListener("input", update);

// subtle typing animation trigger
input.addEventListener("keydown", () => {
  output.style.opacity = 0.4;
  setTimeout(() => output.style.opacity = 1, 120);
});

update();
