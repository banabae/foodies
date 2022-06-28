<?php 
include "koneksi.php";

$image = $_FILES['image']['name'];

$pathImage = 'assets/food/'.$image;
$tmp_image = $_FILES['image']['tmp_name'];

$cek = move_uploaded_file($tmp_image, $pathImage);
// var_dump($cek);die;

$id        = $_POST['id'];
$food_name = $_POST['food_name'];
$price     = $_POST['price'];
$quantity  = $_POST['quantity'];

$q = "UPDATE tbl_food SET food_name ='".$food_name."', price ='".$price."', quantity ='".$quantity."', image ='".$image."' WHERE id_food = ".$id."";

$q_update = mysqli_query($cek_koneksi, $q);

if ($q_update) {
	echo json_encode("Success");
}else{
	echo json_encode("Error!");
}	
