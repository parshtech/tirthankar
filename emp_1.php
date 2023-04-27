<?php
$servername = "shareddb-w.hosting.stackcp.net";
$username = "akshay-f83b";
$password = "Tirthankar@1";
$dbname = "tirthankar-313439bf3d";
$table = "Employees";
$conn = mysqli_connect($servername, $username, $password, $dbname);
$response = array();
$sql = "select * from employee";
if($conn){
$result = mysqli_query($conn,$sql);
if($result){
$i=0;
while($row = mysqli_fetch_assoc($result)){
	$response[$i]['id'] = $row['id']
	$response[$i]['first_name'] = $row['first_name']
	$response[$i]['last_name'] = $row['last_name']
			i++
	}
	echo json_encode($response,JSON_PRETTY_PRINT);
}

} else {
	echo "DB Connection failed";
}

$conn-close();
?>

