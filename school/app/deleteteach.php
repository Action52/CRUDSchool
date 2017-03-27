<?php
require_once "../models/Teacher.php";
$db = new Database;
$user = new Teacher($db);
$id = filter_input(INPUT_GET, 'user', FILTER_VALIDATE_INT);

if( $id )
{
    $user->setId($id);
    $user->delete();
    $user->deletelog();

}
header("Location:" . Teacher::baseurl() . "app/teacherlist.php");