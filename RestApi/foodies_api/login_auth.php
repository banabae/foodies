<?php 
include "koneksi.php";

$email  = $_POST['email'];
$pass   = $_POST['password'];

$query  = "SELECT * FROM tbl_user WHERE email = '".$email."' AND password = '".$pass."'";

$result = mysqli_query($cek_koneksi, $query);
$count  = mysqli_num_rows($result);
$get_data = mysqli_fetch_array($result);

if ($count == 1) {
	echo json_encode([
		'status' => 'Success',
		'name' => $get_data['name'],
	]);
} else {
	echo json_encode([
		'status' => 'Error',
		'name' => "",
	]);
}
