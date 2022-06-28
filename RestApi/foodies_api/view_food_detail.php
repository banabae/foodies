<?php 
include "koneksi.php";

$id = $_POST['id'];

$query = "SELECT * FROM tbl_food WHERE id_food = ".$id;
$sql = mysqli_query($cek_koneksi, $query);
$result = mysqli_fetch_row($sql);

echo json_encode($result);