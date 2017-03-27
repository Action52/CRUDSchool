<?php


include('../session.php');




require_once "../models/User.php";
if (empty($_POST['submit']))
{
      header("Location:" . User::baseurl() . "app/list.php");
      exit;
}

$conex = "host=localhost port=5432 dbname=tutoringnew user=postgres password=";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());


$args = array(
    'id_teacher'  => FILTER_SANITIZE_NUMBER_INT,
    'id_subject'  => FILTER_SANITIZE_NUMBER_INT,
    'topic'  => FILTER_SANITIZE_STRING,
    'date'  => FILTER_SANITIZE_STRING,
);


$post = (object)filter_input_array(INPUT_POST, $args);
$id_student = $_SESSION['id'];
$id_teacher = $post->id_teacher;
$id_tutoreo = $post->id_teacher;
$date = $post->date;


$result  = pg_query_params($cnx,'SELECT id_teacher,id_tutoring FROM teacher_has_tutoring_hours WHERE id = $1', array($id_teacher));
 $row = pg_fetch_array($result);
 	$id_teacher = $row["id_teacher"];
 	$id_tutoring = $row["id_tutoring"];



 

$db = new Database;
$user = new User($db);
$user->setid_student($id_student);
$user->setid_teacher($id_teacher);
$user->setid_subject($post->id_subject);
$user->setid_tutoring($id_tutoring);
$user->settopic($post->topic);
$user->setdate($post->date);
$user->comprobar($id_teacher,$id_tutoring,$date);
$user->save();
header("Location:" . User::baseurl() . "app/list.php");