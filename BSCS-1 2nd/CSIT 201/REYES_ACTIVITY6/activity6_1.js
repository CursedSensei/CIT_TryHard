function darkymode() {
    var bodyDom = document.getElementById("darky-body");
    var buttonDom = document.getElementById("darky-button")

    if (bodyDom.classList.contains("darky")) {
        bodyDom.classList.remove("darky");
        buttonDom.textContent = "LIGHT MODE"
    } else {
        bodyDom.classList.add("darky");
        buttonDom.textContent = "DARK MODE"
    }
}

document.getElementById("darky-button").addEventListener("click", darkymode);