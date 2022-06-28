<?php 
include "koneksi.php";

$image = $_FILES['image']['name'];

$pathImage = 'assets/food/'.$image;
$tmp_image = $_FILES['image']['tmp_name'];

$cek = move_uploaded_file($tmp_image, $pathImage);
// var_dump($cek);die;

$food_name = $_POST['food_name'];
$price     = $_POST['price'];
$quantity  = $_POST['quantity'];

$q = "INSERT INTO  tbl_food(food_name, price, quantity, image) VALUES ('".$food_name."','".$price."','".$quantity."','".$image."') ";

$q_insert = mysqli_query($cek_koneksi, $q);

if ($q_insert) {
	echo json_encode("Success");
}else{
	echo json_encode("Error!");
}	
