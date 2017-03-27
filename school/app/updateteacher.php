<?php
require_once "../models/Teacher.php";
if (empty($_POST['submit']))
{
      header("Location:" . Teacher::baseurl() . "app/list.php");
      exit;
}
$args = array(
    'id'        => FILTER_VALIDATE_INT,
    'te_name'  => FILTER_SANITIZE_STRING,
    'password'  => FILTER_SANITIZE_STRING,
);

$post = (object)filter_input_array(INPUT_POST, $args);

if( $post->id === false )
{
    header("Location:" . User::baseurl() . "app/teacherlist.php");
}

$password = md5($post->password);

$db = new Database;
$user = new Teacher($db);
$user->setId($post->id);
$user->setUsername($post->te_name);
$user->setPassword($password);
$user->update();
header("Location:" . Teacher::baseurl() . "app/teacherlist.php");