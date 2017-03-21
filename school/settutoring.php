<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Add tutoring hours</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
</head>
<body>
  <?php
    require_once "Teacher.php";
    require_once "Subject.php";
  ?>
    <div class="container">
        <div class="col-lg-12">
          <?php
          $idTeacher = $_POST['idTeacher'];
          echo $_POST['idTeacher'];
          $db = new Database;
          $user = new Teacher($db);
          $subject = new Subject($db);
          $subjects = $subject->get();
          ?>
            <h2 class="text-center text-primary">Add Tutoring</h2>
          <form action="addtutoring.php" method="POST">

                <?php $idTeacher = $_POST['idTeacher'];?>
                <input type="hidden" id = "idTeacher" name = "idTeacher" value ="<?php echo $idTeacher?>">

                <div class="form-group">
                    <label for="start">Start hour</label>
                    <input type="text" name="start" value="" class="form-control" id="start" placeholder="Start">
                </div>
                <div class="form-group">
                    <label for="end">End hour</label>
                    <input type="text" name="end" value="" class="form-control" id="end" placeholder="End">
                </div>
                <div class="form-group">
                    <label for="days">Days</label>
                    <input type="text" name="days" value="" class="form-control" id="days" placeholder="days">
                </div>
                <div class="form-group">
                    <label for="availability">Availability (0 for always, 1 for maybe)</label>
                    <input type="text" name="availability" value="" class="form-control" id="availability" placeholder="availability">
                </div>
                <input type="submit" name="submitBtn" class="btn btn-default" value="Save Tutoring session" />
            </form>

        </div>
    </div>


</body>
</html>
