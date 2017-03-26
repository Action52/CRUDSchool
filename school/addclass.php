<?php
include('session.php');



?>
<?php
  require_once "Subject.php";
  require_once "ClassHours.php";
  require_once "Teacher.php";
  /*if (empty($_POST['submit']))
  {
        header("index.php");
        exit;
  }
  */
  echo $_POST['idTeacher'];
  $args = array(
      'subjectname'  => FILTER_SANITIZE_STRING,
      'start'  => FILTER_SANITIZE_STRING,
      'end' => FILTER_SANITIZE_STRING,
      'days' => FILTER_SANITIZE_STRING
  );

  $post = (object)filter_input_array(INPUT_POST, $args);

  $db = new Database;

  $subject = new Subject($db);
  $classhours = new ClassHours($db);
  $teacher = new Teacher($db);

  $idTeacher = $_POST['idTeacher'];
  $idTeacher = intval($idTeacher);
  echo $idTeacher;
  $teacher->setId($idTeacher);
  $teacher->getId();

    //Save new subject
    $subject->setName($post->subjectname);
    //Este check sustituye a save, revisa que exista y si no, lo agrega
    $subject->check();

    //Save class
    $classhours->setStart($post->start);
    $classhours->setEnd($post->end);
    $classhours->setDays($post->days);

    //Este check sustituye a save, revisa que exista y si no, lo agrega
    $classhours->check();

    //Save teacher
    $teacher->add_class($classhours->getId());
    $teacher->add_subject($subject->getId());

?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Set class hours</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
</head>
<body>
    <?php
    require_once "Teacher.php";
    ?>
    <div class="container">
        <div class="col-lg-12">
            <h2 class="text-center text-primary">Add more class hours</h2>
            <form action = "<?php echo Teacher::baseurl() ?>setclass.php" method = "POST">
            <input type="hidden" id = "idTeacher" name = "idTeacher" value ="<?php echo $_POST['idTeacher']?>">
            <br>
            <input type="submit" name="submit" class="btn btn-default" value="Create classes" />
            </form>

            <form action = "<?php echo Teacher::baseurl() ?>endclasses.php" method = "POST">
            <input type="hidden" id = "idTeacher" name = "idTeacher" value ="<?php echo $_POST['idTeacher']?>">
            <br>
            <input type="submit" name="submit" class="btn btn-default" value="End editing" />
            </form>
        </div>
    </div>
</body>
</html>
