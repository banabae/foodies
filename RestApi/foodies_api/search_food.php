<?php 
include "koneksi.php";

$cari = $_POST['cari'];

$query = "SELECT * FROM tbl_food WHERE food_name LIKE '%".$cari."%' OR price LIKE '%".$cari."%' OR quantity LIKE '%".$cari."%'";
$sql = mysqli_query($cek_koneksi, $query);

// echo json_encode($sql->fetch_assoc());die;

$result = array();

while ($rowData = mysqli_fetch_array($sql)) {
	$result[] = $rowData;
}

echo json_encode([
	'status' => 'Success',
	'data'   => $result
]);