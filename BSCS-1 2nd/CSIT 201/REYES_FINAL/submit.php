<?php 
if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !isset($_POST['fname']) || !isset($_POST['lname']) || !isset($_POST['bday']) || !isset($_POST['gender']) || !isset($_POST['email']) || !isset($_POST['password'])) {
    header("location: index.html");
    exit;
}

$conn = new mysqli("localhost", "root", "", "reyes_final");

if ($conn->connect_error) {
    http_response_code(500);
    exit;
}

$first_name = $conn->real_escape_string(trim($_POST['fname']));
$last_name = $conn->real_escape_string(trim($_POST['lname']));
$bday = $conn->real_escape_string(trim($_POST['bday']));
$gender = $conn->real_escape_string(trim($_POST['gender']));
$email = $conn->real_escape_string(trim($_POST['email']));
$password = $conn->real_escape_string(trim($_POST['password']));

if ($first_name === '' || $last_name === '' || $bday === '' || $gender === '' || $email === '' || $password === '') {
    http_response_code(400);
    exit;
}

$result = $conn->query("SELECT id FROM accounts WHERE email = '$email';");
if ($result->num_rows > 0) {
    http_response_code(409);
    exit;
}

if ($conn->query("INSERT INTO accounts (fname, lname, bday, gender, email, password) VALUES ('$first_name', '$last_name', '$bday', '$gender', '$email', '$password');")) {
    http_response_code(200);
} else {
    http_response_code(500);
}
?>