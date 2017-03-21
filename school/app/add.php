<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Listado de usuarios</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
</head>
<body>
    <?php
    require_once "../models/User.php";
    ?>
    <div class="container">
        <div class="col-lg-12">
            <h2 class="text-center text-primary">Add apointment</h2>
            <form action="<?php echo User::baseurl() ?>app/save.php" method="POST">
                <div class="form-group">
                    <label for="id_student">id_student</label>
                    <input type="int" name="id_student" value="" class="form-control" id="id_student" placeholder="id_student">
                </div>
                <div class="form-group">
                    <label for="id_student">id_teacher</label>
                    <input type="int" name="id_teacher" value="" class="form-control" id="id_teacher" placeholder="id_teacher">
                </div>
                <div class="form-group">
                    <label for="id_subject">id_subject</label>
                    <input type="int" name="id_subject" value="" class="form-control" id="id_subject" placeholder="id_subject">
                </div>
                <div class="form-group">
                    <label for="id_tutoring">id_tutoring</label>
                    <input type="int" name="id_tutoring" value="" class="form-control" id="id_tutoring" placeholder="id_tutoring">
                </div>
                <div class="form-group">
                    <label for="topic">topic</label>
                    <input type="text" name="topic" value="" class="form-control" id="topic" placeholder="topic">
                </div>
                <div class="form-group">
                    <label for="date">date</label>
                    <input type="date" name="date" value="" class="form-control" id="date" placeholder="date">
                </div>
                <input type="submit" name="submit" class="btn btn-default" value="Save user" />
            </form>
        </div>
    </div>
</body>
</html>