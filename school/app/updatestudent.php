<?php
require_once "../models/Student.php";
if (empty($_POST['submit']))
{
      header("Location:" . Student::baseurl() . "app/studentlist.php");
      exit;
}
$args = array(
    'id'        => FILTER_VALIDATE_INT,
    'st_name'  => FILTER_SANITIZE_STRING,
    'password'  => FILTER_SANITIZE_STRING,
);

$post = (object)filter_input_array(INPUT_POST, $args);

if( $post->id === false )
{
    header("Location:".Student::baseurl() . "app/studentlist.php");
}

$password = md5($post->password);

$db = new Database;
$user = new Student($db);
$user->setId($post->id);
$user->setst_name($post->st_name);
$user->setPassword($password);
$user->update();
header("Location:" . Student::baseurl() . "app/studentlist.php");