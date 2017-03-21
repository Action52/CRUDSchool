<?php
require_once "Teacher.php";
if (empty($_POST['submit']))
{
      header("Location:" . Teacher::baseurl() . "index.php");
      exit;
}

$args = array(
    'username'  => FILTER_SANITIZE_STRING,
    'password'  => FILTER_SANITIZE_STRING,
    'department' => FILTER_SANITIZE_STRING
);

$post = (object)filter_input_array(INPUT_POST, $args);

$db = new Database;
$user = new Teacher($db);
$user->setUsername($post->username);
$user->setPassword($post->password);
$user->setDepartment($post->department);
$user->save();
header("Location:" . Teacher::baseurl() . "index.php");
