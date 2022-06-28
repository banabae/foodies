<?php 

$cek_koneksi = mysqli_connect('localhost', 'root', '', 'foodies_db');
if (!$cek_koneksi) {
	echo "Koneksi Database Gagal!";
}