<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

include "config.php";

$servername = "shareddb-w.hosting.stackcp.net";
$username = "akshay-f83b";
$password = "Tirthankar@1";
$dbname = "tirthankar-313439bf3d";
$table = "employees";
$sql = "select * from employee";
$conn = mysqli_connect($servername, $username, $password, $dbname);
$result = mysqli_query($conn,$sql);

if(mysqli_num_rows($result) > 0){
	$output = mysqli_fetch_all($result,MYSQLI_ASSOC);
	echo json_encode($output);
} else {
	echo json_encode(array('message' => 'No Record Found.','status' => false));
}	
?>

