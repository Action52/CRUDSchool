<?php
require_once "../models/User.php";
if (empty($_POST['submit']))
{
      header("Location:" . User::baseurl() . "app/list.php");
      exit;
}

$args = array(
    'id_student'  => FILTER_SANITIZE_NUMBER_INT,
    'id_teacher'  => FILTER_SANITIZE_NUMBER_INT,
    'id_subject'  => FILTER_SANITIZE_NUMBER_INT,
    'topic'  => FILTER_SANITIZE_STRING,
    'date'  => FILTER_SANITIZE_STRING,
);

$post = (object)filter_input_array(INPUT_POST, $args);

$id_teacher = $post->id_teacher;

$result = pg_query('SELECT id_teacher,id_tutoring FROM teacher_has_tutoring_hours WHERE id = "$id_teacher"');
 if($row = pg_fetch_array($result)){
 	$id_teacher = $row["id_teacher"] ;
 	$id_tutoring = $row["id_tutoring"] ;

 }

$db = new Database;
$user = new User($db);
$user->setid_student($post->id_student);
$user->setid_teacher($id_teacher);
$user->setid_subject($post->id_subject);
$user->setid_tutoring($id_tutoring);
$user->settopic($post->topic);
$user->setdate($post->date);
$user->save();
header("Location:" . User::baseurl() . "app/list.php");