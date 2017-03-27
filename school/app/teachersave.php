<?php
require_once "../models/Teacher.php";
if (empty($_POST['submit']))
{
      header("Location:" . Teacher::baseurl() . "app/teacherlist.php");
      exit;
}

$args = array(
    'te_name'  => FILTER_SANITIZE_STRING,
    'password'  => FILTER_SANITIZE_STRING,
);

$post = (object)filter_input_array(INPUT_POST, $args);

$password = md5($post->password);

$db = new Database;
$user = new Teacher($db);
$user->setUsername($post->te_name);
$user->setPassword($password);
$user->save();
header("Location:" . Teacher::baseurl() . "app/teacherlist.php");