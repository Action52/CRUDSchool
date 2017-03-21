<?php
require_once "../models/User.php";
if (empty($_POST['submit']))
{
      header("Location:" . User::baseurl() . "app/list.php");
      exit;
}
$args = array(
    'id'        => FILTER_VALIDATE_INT,
    'id_student'        => FILTER_VALIDATE_INT,
    'id_teacher'        => FILTER_VALIDATE_INT,
    'id_subject'        => FILTER_VALIDATE_INT,
    'id_tutoring'        => FILTER_VALIDATE_INT,
   'topic'  => FILTER_SANITIZE_STRING,
    'date'  => FILTER_SANITIZE_STRING,
    
);

$post = (object)filter_input_array(INPUT_POST, $args);

if( $post->id === false )
{
    header("Location:" . User::baseurl() . "app/list.php");
}

$db = new Database;
$user = new User($db);
$user->setId($post->id);
$user->setid_student($post->id_student);
$user->setid_teacher($post->id_teacher);
$user->setid_subject($post->id_subject);
$user->setid_tutoring($post->id_tutoring);
$user->settopic($post->topic);
$user->setdate($post->date);
$user->update();
header("Location:" . User::baseurl() . "app/list.php");