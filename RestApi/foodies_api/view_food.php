<?php 
include "koneksi.php";

$query = "SELECT * FROM tbl_food";
$sql = mysqli_query($cek_koneksi, $query);

$result = array();

while ($rowData = $sql->fetch_assoc()) {
	$result[] = $rowData;
}

echo json_encode($result);