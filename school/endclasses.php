<?php

include('session.php');




  $idTeacher = $_POST['idTeacher'];
  require_once "Teacher.php";
  require_once("Database.php");
  $db = new Database;
  $teacher = new Teacher($db);
  $teacher->setId($idTeacher);

  $teacher->registerClasses();


  header('Location: teacherlanding.php');


?>
