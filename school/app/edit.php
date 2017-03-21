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
    $id = filter_input(INPUT_GET, 'user', FILTER_VALIDATE_INT);
    if( ! $id )
    {
        header("Location:" . User::baseurl() . "app/list.php");
    }
    $db = new Database;
    $newUser = new User($db);
    $newUser->setId($id);
    $user = $newUser->get();
    $newUser->checkUser($user);

    ?>
    <div class="container">
        <div class="col-lg-12">
            <h2 class="text-center text-primary">Edit appointment </h2>
            <form action="<?php echo User::baseurl() ?>app/update.php" method="POST">
                <div class="form-group">
                    <label for="id_student">id_student</label>
                    <input type="int" name="id_student" value="<?php echo $user->id_student ?>" class="form-control" id="id_student" placeholder="id_student">
                </div>
                <div class="form-group">
                    <label for="id_teacher">id_teacher</label>
                    <input type="int" name="id_teacher" value="<?php echo $user->id_teacher ?>" class="form-control" id="id_teacher" placeholder="id_teacher">
                </div>
                <div class="form-group">
                    <label for="id_subject">id_subject</label>
                    <input type="int" name="id_subject" value="<?php echo $user->id_subject ?>" class="form-control" id="id_subject" placeholder="id_subject">
                </div>
                <div class="form-group">
                    <label for="id_tutoring">id_tutoring</label>
                    <input type="int" name="id_tutoring" value="<?php echo $user->id_tutoring ?>" class="form-control" id="id_tutoring" placeholder="id_tutoring">
                </div>
                <div class="form-group">
                    <label for="topic">topic</label>
                    <input type="text" name="topic" value="<?php echo $user->topic ?>" class="form-control" id="topic" placeholder="topic">
                </div>
                <div class="form-group">
                    <label for="date">date</label>
                    <input type="date" name="date" value="<?php echo $user->date ?>" class="form-control" id="date" placeholder="date">
                </div>
                <input type="hidden" name="id" value="<?php echo $user->id ?>" />
                <input type="submit" name="submit" class="btn btn-default" value="Update user" />
            </form>
        </div>
    </div>
</body>
</html>