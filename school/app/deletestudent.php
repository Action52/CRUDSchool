<?php
require_once "../models/Student.php";
$db = new Database;
$user = new Student($db);
$id = filter_input(INPUT_GET, 'user', FILTER_VALIDATE_INT);

if( $id )
{
    $user->setId($id);
    $user->delete();
}
header("Location:" . Student::baseurl() . "app/studentlist.php");