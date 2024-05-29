document.getElementById("submit").addEventListener("click", function () {
    if (document.getElementById("email").value === "" || document.getElementById("message").value === "") {
        alert("Incomplete Form");
        return;
    }
    alert("Your message has been submitted or emailed. Thank you!");
    document.getElementById("email").value = "";
    document.getElementById("message").value = ""
})

const countdown_date = new Date("May 31, 2024 00:00:00").getTime();

function countDown() {
    let date_today = new Date().getTime();

    let days_left = countdown_date - date_today;

    let days = Math.floor(days_left / (1000 * 60 * 60 * 24));
    let hours = Math.floor((days_left % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    let minutes = Math.floor((days_left % (1000 * 60 * 60)) / (1000 * 60));
    let seconds = Math.floor((days_left % (1000 * 60)) / 1000);

    document.getElementById("hi-day").innerText = Math.floor(days / 10);
    document.getElementById("lo-day").innerText = Math.floor(days  % 10);
    document.getElementById("hi-hour").innerText = Math.floor(hours / 10);
    document.getElementById("lo-hour").innerText = Math.floor(hours % 10);
    document.getElementById("hi-min").innerText = Math.floor(minutes / 10);
    document.getElementById("lo-min").innerText = Math.floor(minutes % 10);
    document.getElementById("hi-sec").innerText = Math.floor(seconds / 10);
    document.getElementById("lo-sec").innerText = Math.floor(seconds % 10)
}

setInterval(countDown, 1000);