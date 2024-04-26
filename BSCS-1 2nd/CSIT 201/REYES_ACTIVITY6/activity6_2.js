function calculate() {
    var radius = parseFloat(document.getElementById("radius").value);

    if (!isNaN(radius)) {
        document.getElementById("circum").value = radius * 2 * Math.PI;
        document.getElementById("area").value = radius * radius * Math.PI;
    } else {
        alert("Please enter a valid number for the radius");
    }
}

document.getElementById("calcBut").addEventListener("click", calculate);