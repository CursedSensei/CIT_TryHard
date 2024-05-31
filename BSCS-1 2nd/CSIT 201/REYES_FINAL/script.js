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

var state = false;
async function animate() {
    if (state) {
        let points = Array(16);
        points[0] = 0;
        points[1] = 90;
        points[2] = 90;
        points[3] = 0;
        points[4] = 210;
        points[5] = 0;
        points[6] = 300;
        points[7] = 90;
        points[8] = 300;
        points[9] = 210;
        points[10] = 210;
        points[11] = 300;
        points[12] = 90;
        points[13] = 300;
        points[14] = 0;
        points[15] = 210;

        while (points[2] > 0) {
            points[1] -= 75/60;
            points[2] -= 75/60;
            points[4] += 75/60;
            points[7] -= 75/60;
            points[9] += 75/60;
            points[10] += 75/60;
            points[12] -= 75/60;
            points[15] += 75/60;
            let point_str = "";
            for (let i = 1; i < 16; i += 2) {
                point_str += points[i-1].toString() + "," + points[i].toString() + " ";
            }
            document.getElementById("poly").setAttribute("points", point_str);
            await new Promise(r => setTimeout(r, 10));
        }
        state = false;
    }
    else {
        let points = Array(16);
        points[0] = 0;
        points[1] = 0;
        points[2] = 0;
        points[3] = 0;
        points[4] = 300;
        points[5] = 0;
        points[6] = 300;
        points[7] = 0;
        points[8] = 300;
        points[9] = 300;
        points[10] = 300;
        points[11] = 300;
        points[12] = 0;
        points[13] = 300;
        points[14] = 0;
        points[15] = 300;

        while (points[2] <= 90) {
            points[1] += 75/60;
            points[2] += 75/60;
            points[4] -= 75/60;
            points[7] += 75/60;
            points[9] -= 75/60;
            points[10] -= 75/60;
            points[12] += 75/60;
            points[15] -= 75/60;
            let point_str = "";
            for (let i = 1; i < 16; i += 2) {
                point_str += points[i-1].toString() + "," + points[i].toString() + " ";
            }
            document.getElementById("poly").setAttribute("points", point_str);
            await new Promise(r => setTimeout(r, 10));
        }
        state = true;
    }
    setTimeout(animate, 0);
}
animate();

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

var allInputs = document.getElementsByTagName("input");

for (let i = 0; i < allInputs.length; i++) {
    if (allInputs[i].type === "radio") continue;

    allInputs[i].addEventListener("change", function () {
        if (this.classList.contains("shake")) {
            this.classList.remove("shake");
        }
    });
}

function submitPage(isReset = false, nullSet = false) {
    const childDom = document.getElementsByClassName("child_section");

    for (let i = 0; i < childDom.length; i++) {
        if (childDom[i].id !== "message_section") {
            childDom[i].hidden = childDom[i].hidden ? false : true;
        }
    }

    if (isReset) {
        for (let i = 0; i < allInputs.length; i++) {
            if (allInputs[i].type === "radio") {
                if (nullSet) {
                    allInputs[i].checked = false;
                }
                continue;
            }
        
            if (allInputs[i].classList.contains("shake")) {
                allInputs[i].classList.remove("shake");
            }

            if (nullSet) {
                allInputs[i].value = "";
            }
        }
    }
}

function displayMessage(message, isSuccess = false) {
    document.getElementById("message_content").innerText = message;

    const mesDom = document.getElementById("message_section");
    mesDom.style.backgroundColor = isSuccess ? "green" : "red";
    mesDom.hidden = false;
}

document.getElementById("main_form").addEventListener("submit", function (e) {
    e.preventDefault();
    submitPage(true);

    const fname = document.getElementById("firstname").value.trim();
    const lname = document.getElementById("lastname").value.trim();
    const bday = document.getElementById("birthday").value.trim();
    const gender = document.getElementById("male").checked ? "Male" : document.getElementById("female").checked ? "Female" : document.getElementById("other_gen").checked ? "Other" : "";
    const email = document.getElementById("email").value.trim();
    const password = document.getElementById("password").value.trim();
    const conpassword = document.getElementById("conpassword").value.trim();

    let invalid = false;
    if (fname === "") {
        invalid = true;
        document.getElementById("firstname").classList.add("shake");
    }
    if (lname === "") {
        invalid = true;
        document.getElementById("lastname").classList.add("shake");
    }
    if (bday === "") {
        invalid = true;
        document.getElementById("birthday").classList.add("shake");
    }
    if (gender === "") {
        invalid = true;
        document.getElementsByTagName("fieldset")[0].classList.add("shake");
    }
    if (email === "") {
        invalid = true;
        document.getElementById("email").classList.add("shake");
    }
    if (password === "") {
        invalid = true;
        document.getElementById("password").classList.add("shake");
    }
    if (conpassword === "") {
        invalid = true;
        document.getElementById("conpassword").classList.add("shake");
    }

    if (invalid) {
        submitPage();
        displayMessage("Please insert all required info");
        return;
    }

    if (password !== conpassword) {
        document.getElementById("password").classList.add("shake");
        document.getElementById("conpassword").classList.add("shake");

        submitPage();
        displayMessage("Password is incorrect");
        return;
    }

    var userData = new FormData();

    userData.append("fname", fname);
    userData.append("lname", lname);
    userData.append("bday", bday);
    userData.append("gender", gender);
    userData.append("email", email);
    userData.append("password", password);

    fetch("submit.php", {
        method: "POST",
        body: userData,
    }).then((response) => {
        if (response.status == 200) {
            submitPage(true, true);
            displayMessage("User Successfully Registered", true);
        } else if (response.status == 400) {
            submitPage();
            displayMessage("Please insert all required info");
        } else if (response.status == 409) {
            submitPage(true);
            displayMessage("This user already exist");
        } else {
            submitPage();
            displayMessage("Error. Please try again later");
        }
    });
});