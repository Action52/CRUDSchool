<?php
    $tkn = $_POST['token'];
    $name = $_POST['name'];
    require_once "Admin.php";

    $db = new Database;
    $admin = new Admin($db);


    $admin->confirmToken($tkn);

    header('Location: index.php');

?>
