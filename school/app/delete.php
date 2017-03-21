<?php
require_once "../models/User.php";
$db = new Database;
$user = new User($db);
$id = filter_input(INPUT_GET, 'user', FILTER_VALIDATE_INT);

if( $id )
{
    $user->setId($id);
    $user->delete();
}
header("Location:" . User::baseurl() . "app/list.php");