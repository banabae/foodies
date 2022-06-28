<?php 

	include "koneksi.php";

	$id = $_POST['id'];

	$link->query("DELETE FROM tbl_food WHERE id_food = '".$id."'");

	echo json_encode("Success");