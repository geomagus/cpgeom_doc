/* random-crs.js — version chaos safe */

document$.subscribe(() => {
  const original = document.getElementById("crsImg");
  if (!original) return; // stop si élément absent

  if (original.dataset.listenerAttached) return;
  original.dataset.listenerAttached = "true";

  original.addEventListener("click", () => {

    const img = document.createElement("img");
    img.src = "/assets/crs.png"; // vérifier que l'image existe
    const size = Math.random() * 120 + 60;
    img.style.position = "fixed";
    img.style.left = Math.random() * (window.innerWidth - size) + "px";
    img.style.top = Math.random() * (window.innerHeight - size) + "px";
    img.style.width = size + "px";
    img.style.transform = `rotate(${Math.random()*360}deg)`;
    img.style.zIndex = 9999;
    img.style.cursor = "grab";

    img.addEventListener("dblclick", () => img.remove());

    makeDraggable(img);
    document.body.appendChild(img);
  });
});

function makeDraggable(el) {
  let offsetX, offsetY;

  el.addEventListener("mousedown", e => {
    offsetX = e.clientX - el.offsetLeft;
    offsetY = e.clientY - el.offsetTop;
    el.style.cursor = "grabbing";

    const onMove = e => {
      el.style.left = (e.clientX - offsetX) + "px";
      el.style.top = (e.clientY - offsetY) + "px";
    };
    const onUp = () => {
      document.removeEventListener("mousemove", onMove);
      document.removeEventListener("mouseup", onUp);
      el.style.cursor = "grab";
    };
    document.addEventListener("mousemove", onMove);
    document.addEventListener("mouseup", onUp);
  });
}