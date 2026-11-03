// je récupère le bouton "en savoir plus" et le bloc de texte caché
const bouton = document.getElementById("btvoir");
const suite = document.querySelector(".suite");

// au cas où le script est chargé sur une page sans ce bouton, sinon ça plante
if (bouton && suite) {
    bouton.addEventListener("click", () => {
        // toggle = ça met la classe si elle y est pas, ça l'enlève si elle y est
        suite.classList.toggle("visible");

        // je change aussi le texte du bouton pour que ce soit plus clair
        if (suite.classList.contains("visible")) {
            bouton.textContent = "réduire";
        } else {
            bouton.textContent = " en savoir plus";
        }
    });
}