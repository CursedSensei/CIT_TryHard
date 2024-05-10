var count = 0;

function reset() {
    document.getElementById("female").checked = false;
    document.getElementById("male").checked = false;
    document.getElementById("firstname").value = "";
    document.getElementById("lastname").value = "";
    document.getElementById("date").value = "";
}

function addCell(row, ind, str, odd = false) {
    let cell = row.insertCell(ind);
    cell.innerHTML = str;
    if (odd) cell.classList.add("odd");
}

function addRow() {
    var row = document.getElementById("output").insertRow(count + 1);
    addCell(row, 0, document.getElementById("firstname").value, count % 2 === 1);
    addCell(row, 1, document.getElementById("lastname").value, count % 2 === 1);
    addCell(row, 2, document.getElementById("female").checked ? "Female" : "Male", count % 2 === 1);
    addCell(row, 3, document.getElementById("date").value, count++ % 2 === 1);

}

function validate() {
    if (document.getElementById("female").checked === document.getElementById("male").checked) {
        return false;
    }

    if (document.getElementById("firstname").value.trim() === "") return false;
    if (document.getElementById("lastname").value.trim() === "") return false;
    if (document.getElementById("date").value === "") return false;

    return true;
}

document.getElementById("male").addEventListener("click", function () {
    document.getElementById("female").checked = false;
});

document.getElementById("female").addEventListener("click", function () {
    document.getElementById("male").checked = false;
});

document.getElementById("submit").addEventListener("click", function () {
    if (validate()) {
        addRow();
    } else {
        alert("Missing or Invalid Information!");
    }
});

document.getElementById("cancel").addEventListener("click", reset);