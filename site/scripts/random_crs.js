/* random-crs.js — VERSION CHAOS */

document$.subscribe(function () {

  const original = document.getElementById("crsImg");
  if (!original) return;

  if (original.dataset.listenerAttached) return;
  original.dataset.listenerAttached = "true";

  original.addEventListener("click", function () {
    spawnChaos();
  });

});


function spawnChaos() {

  const img = document.createElement("img");

  // ⚠️ IMPORTANT : chemin absolu
  img.src = "/assets/crs.png";

  const size = Math.random() * 120 + 60; // 60px → 180px
  const rotation = Math.random() * 360;
  const maxWidth = window.innerWidth - size;
  const maxHeight = window.innerHeight - size;

  img.style.position = "fixed";
  img.style.left = Math.random() * maxWidth + "px";
  img.style.top = Math.random() * maxHeight + "px";
  img.style.width = size + "px";
  img.style.transform = `rotate(${rotation}deg)`;
  img.style.zIndex = 9999;
  img.style.cursor = "grab";
  img.style.transition = "transform 0.2s ease";

  img.classList.add("chaos-img");

  makeDraggable(img);

  // Double clic = destruction
  img.addEventListener("dblclick", function () {
    img.remove();
  });

  document.body.appendChild(img);
}


function makeDraggable(element) {

  let offsetX = 0;
  let offsetY = 0;

  element.addEventListener("mousedown", function (e) {

    offsetX = e.clientX - element.offsetLeft;
    offsetY = e.clientY - element.offsetTop;

    element.style.cursor = "grabbing";

    function onMouseMove(e) {
      element.style.left = (e.clientX - offsetX) + "px";
      element.style.top = (e.clientY - offsetY) + "px";
    }

    function onMouseUp() {
      document.removeEventListener("mousemove", onMouseMove);
      document.removeEventListener("mouseup", onMouseUp);
      element.style.cursor = "grab";
    }

    document.addEventListener("mousemove", onMouseMove);
    document.addEventListener("mouseup", onMouseUp);
  });
}