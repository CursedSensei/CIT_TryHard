var loadingWidth = 0;
var isLoading = true;

function loadingExpand() {
    if (loadingWidth >= 100) {
        loadingWidth = 100;
        document.getElementById("loading_child").style.minWidth = loadingWidth + "vw";
        document.getElementById("loading_child").innerText = loadingWidth.toFixed(2) + "%";

        document.getElementById("loading").style.opacity = 0;
        document.getElementById("loading_child").style.color = "black";
        document.getElementById("loading_child").style.borderColor = "black";
        document.getElementById("loading_child").style.marginBottom = "40%";
        return;
    }

    if (!(isLoading && loadingWidth >= 80)) {
        loadingWidth += 0.2;
        document.getElementById("loading_child").style.minWidth = loadingWidth + "vw";
        document.getElementById("loading_child").innerText = loadingWidth.toFixed(2) + "%";
    }

    if (isLoading) {
        setTimeout(loadingExpand, 10 + (loadingWidth / .5));
    } else {
        loadingWidth += 0.2;
        setTimeout(loadingExpand, 1);
    }
}

setTimeout(loadingExpand, 200);

window.onload = () => {
    isLoading = false;
};