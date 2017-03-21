<?php
require_once "../models/logscheme.php";
if (empty($_POST['submit']))
{
      header("Location:" . logscheme::baseurl() . "app/verification.php");
      exit;
}

$args = array(
    'id_teacher'  => FILTER_SANITIZE_NUMBER_INT,
    
);

$post = (object)filter_input_array(INPUT_POST, $args);

$db = new Database;
$user = new logschweme($db);
$user->setid_teacher($post->id_teacher);
header("Location:" . logscheme::baseurl() . "app/aplist.php");