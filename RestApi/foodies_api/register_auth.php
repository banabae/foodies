<?php 
include "koneksi.php";

$email           = $_POST['email'];
$pass            = $_POST['password'];
$name            = $_POST['name'];
$gender          = $_POST['gender'];
$dateofbirth     = $_POST['dateofbirth'];
$password        = $_POST['password'];
$confirmpassword = $_POST['confirmpassword'];

$query  = "SELECT * FROM tbl_user WHERE email = '".$email."'";

$result = mysqli_query($cek_koneksi, $query);
$count  = mysqli_num_rows($result);

if ($password != $confirmpassword) {
	echo json_encode("Error");
} else {
	if ($count == 1) {
		echo json_encode("Error");
	} else {
		$q = "INSERT INTO  tbl_user(email, password, name, gender, dateofbirth, confirmpassword) VALUES ('".$email."','".$pass."','".$name."','".$gender."','".$dateofbirth."','".$confirmpassword."') ";
		$q_insert = mysqli_query($cek_koneksi, $q);

		if ($q_insert) {
			echo json_encode("Success");
		}else{
			echo json_encode("Register Error!");
		}
	}
}
		
