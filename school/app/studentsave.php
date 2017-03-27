<?php
require_once "../models/Student.php";
if (empty($_POST['submit']))
{
      header("Location:" . Student::baseurl() . "app/studentlist.php");
      exit;
}

$args = array(
    'st_name'  => FILTER_SANITIZE_STRING,
    'password'  => FILTER_SANITIZE_STRING,
);

$post = (object)filter_input_array(INPUT_POST, $args);

$password = md5($post->password);

$db = new Database;
$user = new Student($db);
$user->setst_name($post->st_name);
$user->setPassword($password);
$user->save();
header("Location:" . Student::baseurl() . "app/studentlist.php");