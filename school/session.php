<?php
$conex = "host=localhost port=5432 dbname=tutoringnew user=postgres password=";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();
// Storing Session
$user_check=$_SESSION['login_user'];
// SQL Query To Fetch Complete Information Of User
//Completar esquema para postgres. Solo falta verificar sesion en las paginas target
$ses_sql=pg_query($cnx, "select username from login where username='$user_check'");
$row = pg_fetch_assoc($ses_sql);
$login_session =$row['username'];
if(!isset($login_session)){
pg_close($connection); // Closing Connection
header('Location: index.php'); // Redirecting To Home Page
}
?>