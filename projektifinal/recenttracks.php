<?php

session_start();
if (!isset($_SESSION['user_id'])) {
    header('Location: login.html');
    exit;
}
$user_id = $_SESSION['user_id'];

$conn = new mysqli("localhost", "root", "", "music_platform");
$stmt = $conn->prepare("
    SELECT m.song_title, m.file_name, m.file_path, rp.played_at
    FROM recent_plays rp
    JOIN music m ON rp.music_id = m.id
    WHERE rp.user_id = ?
    ORDER BY rp.played_at DESC
    LIMIT 10
");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$stmt->bind_result($song_title, $file_name, $file_path, $played_at);

$recent_tracks = [];
while ($stmt->fetch()) {
    $recent_tracks[] = [
        'song_title' => $song_title,
        'file_name' => $file_name,
        'file_path' => $file_path,
        'played_at' => $played_at
    ];
}
$stmt->close();
$conn->close();
?>
<!DOCTYPE html>
<html>
<head>
    <title id = "recenttrack">Your Recent Tracks</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .dashboard-container {
            max-width: 900px;
            margin: 40px auto;

            border-radius: 10px;
            padding: 32px 24px;

        }
        #recenttrack {
            margin: 30px;
            padding-top: 50px;
        }
 
    </style>
</head>
<body>
    <ul class="nav">
        <li class="li"><a href="home1.php" id="nav1">Home</a></li>
        <li class="li"><a href="upload.php" id="nav2">Upload Music</a></li>
        <li class="li"><a href="logout.php" id="nav3">Logout</a></li>
        <li class="li"><a href="recenttracks.php" id="nav4">Recent Tracks</a></li>
    </ul>
    <div class="dashboard-container">
        <h1>Your Recent Tracks</h1>
        <?php if (empty($recent_tracks)): ?>
            <div class="no-tracks">You have not played any music yet.</div>
        <?php else: ?>
            <table>
                <thead>
                    <tr>
                        <th>Song Title</th>
                        <th>File Name</th>
                        <th>Played At</th>
                        <th>Listen</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($recent_tracks as $track): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($track['song_title']); ?></td>
                            <td><?php echo htmlspecialchars($track['file_name']); ?></td>
                            <td><?php echo $track['played_at']; ?></td>
                            <td>
                                <audio controls src="<?php echo htmlspecialchars($track['file_path']); ?>"></audio>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        <?php endif; ?>
        <a href="home1.php">Back to Home</a>
    </div>
</body>
</html>