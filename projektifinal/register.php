<?php
header('Content-Type: application/json');
error_reporting(0);
ini_set('display_errors', 0);
session_start();

$servername = "localhost";
$dbusername = "root";
$dbpassword = "";
$dbname = "spfest";

$conn = new mysqli($servername, $dbusername, $dbpassword, $dbname);

if ($conn->connect_error) {
    echo json_encode(["success" => false, "error" => "Database connection failed"]);
    exit();
}

$username = $_POST["username"] ?? '';
$email = $_POST["email"] ?? '';
$pass = isset($_POST["password"]) ? password_hash($_POST["password"], PASSWORD_DEFAULT) : '';

if (!$username || !$email || !$pass) {
    echo json_encode(["success" => false, "error" => "Missing username or password"]);
    exit();
}

$stmt = $conn->prepare("SELECT user_id FROM users WHERE username = ? OR email = ?");
$stmt->bind_param("ss", $username, $email);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    echo json_encode(["success" => false, "error" => "Username or Email already exists"]);
    $stmt->close();
    $conn->close();
    exit();
}
$stmt->close();

$stmt = $conn->prepare("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
$stmt->bind_param("sss", $username, $email, $pass);

if ($stmt->execute()) {
    $_SESSION['username'] = $username;
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "error" => "Error registering user"]);
}

$stmt->close();
$conn->close();
exit();