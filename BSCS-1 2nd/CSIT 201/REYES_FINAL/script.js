var curTop = 2000;
var curLeft = -1000;

async function cursorChase() {
    const trail1Dom = document.getElementById("trail1");
    const trail2Dom = document.getElementById("trail2");
    const trail3Dom = document.getElementById("trail3");
    const trail4Dom = document.getElementById("trail4");
    var ctop = 2000;
    var cleft = -1000;

    while (true) {
        ctop = ((curTop - ctop) / 17) + ctop + 0.3;
        cleft = ((curLeft - cleft) / 17) + cleft + 0.3;
        trail4Dom.style.top = ctop + "px";
        trail4Dom.style.left = cleft + "px";

        let offTop = (curTop - ctop) / 4;
        let offLeft = (curLeft - cleft) / 4;

        trail3Dom.style.top = (ctop + offTop) + "px";
        trail3Dom.style.left = (cleft + offLeft) + "px";

        trail2Dom.style.top = (ctop + (offTop * 2)) + "px";
        trail2Dom.style.left = (cleft + (offLeft * 2)) + "px";

        trail1Dom.style.top = (ctop + (offTop * 3)) + "px";
        trail1Dom.style.left = (cleft + (offLeft * 3)) + "px";

        await new Promise(r => setTimeout(r, 5));
    }
}

document.onmousemove = function (event) {
    const curDom = document.getElementById("cursor");

    curTop = event.clientY - 16;
    curLeft = event.clientX - 18;

    curDom.style.top = curTop + "px";
    curDom.style.left = curLeft + "px";
};

cursorChase();

document.getElementById("male").addEventListener("click", function () {
    document.getElementById("female").checked = false;
    document.getElementById("other_gen").checked = false;
});

document.getElementById("female").addEventListener("click", function () {
    document.getElementById("male").checked = false;
    document.getElementById("other_gen").checked = false;
});

document.getElementById("other_gen").addEventListener("click", function () {
    document.getElementById("male").checked = false;
    document.getElementById("female").checked = false;
});

function submitPage() {
    const childDom = document.getElementsByClassName("child_section");

    for (let i = 0; i < childDom.length; i++) {
        if (childDom[i].id !== "message_section") {
            childDom[i].hidden = childDom[i].hidden ? false : true;
        }
    }
}

document.getElementById("submit").addEventListener("click", function () {
    submitPage();
});