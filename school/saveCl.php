<?php
require_once "Subject.php";
require_once "ClassHours.php";
require_once "Teacher.php";
if (empty($_POST['submit']))
{
      header("index.php");
      exit;
}

$args = array(
    'subjectname'  => FILTER_SANITIZE_STRING,
    'start'  => FILTER_SANITIZE_STRING,
    'end' => FILTER_SANITIZE_STRING,
    'days' => FILTER_SANITIZE_STRING
);

$post = (object)filter_input_array(INPUT_POST, $args);

$db = new Database;

//Falta teacher
$subject = new Subject($db);
$classhours = new ClassHours($db);
$teacher = new Teacher($db);


//Save new subject
$subject->setName($post->subjectname);
$subject->save();


//Class hours

$classhours->setStart($post->start);
$classhours->setEnd($post->end);
$classhours->setDays($post->days);
$classhours->save();
$classId = $classhours->getId();


header("index.php");
