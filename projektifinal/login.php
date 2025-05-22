<?php
error_reporting(0);
ini_set('display_errors', 0);
session_start();
header('Content-Type: application/json');
error_reporting(0);
ini_set('display_errors', 0);

$host = 'localhost';
$db   = 'spfest'; // your database name
$user = 'root';   // your db user (default for XAMPP)
$pass = '';       // your db password (default for XAMPP)

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    echo json_encode(['success' => false, 'error' => 'Database connection failed']);
    exit;
}

$username = $_POST['username'] ?? '';
$password = $_POST['password'] ?? '';

if (!$username || !$password) {
    echo json_encode(['success' => false, 'error' => 'Missing username or password']);
    exit;
}

// Query for user by name or email
$stmt = $conn->prepare("SELECT id, name, password FROM users WHERE name = ? OR email = ?");
$stmt->bind_param("ss", $username, $username);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows === 1) {
    $stmt->bind_result($user_id, $name, $hashed_password);
    $stmt->fetch();
    if (password_verify($password, $hashed_password)) {
        $_SESSION['user_id'] = $user_id;
        $_SESSION['username'] = $name;
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => 'Incorrect password']);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'No user found']);
}

$stmt->close();
$conn->close();