<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "shops";
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
	die("Connection Failed: " . $conn->connect_error);
}
$sql = "select * from shops";
$result = $conn->query($sql);
$response = array();
if ($result->num_rows > 0) {
	while($row = $result->fetch_assoc()){
		array_push($response,$row);
	}
}
$conn-close();
header('Content-Type: application/json');
echo json_encode($response);
?>

