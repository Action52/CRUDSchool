
<?php
include('../session.php');



?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Listado de estudiantes</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
</head>
<body>
    <?php
    require_once "../models/Student.php";
    $id = filter_input(INPUT_GET, 'user', FILTER_VALIDATE_INT);
    if( ! $id )
    {
        header("Location:" . Student::baseurl() . "app/studentlist.php");
    }
    $db = new Database;
    $newUser = new Student($db);
    $newUser->setId($id);
    $user = $newUser->get();
    $newUser->checkUser($user);
    ?>
    <div class="container">
        <div class="col-lg-12">
            <h2 class="text-center text-primary">Editar estudiante</h2>
             <form action="<?php echo Student::baseurl() ?>app/updatestudent.php" method="POST">
                <div class="form-group">
                    <label for="st_name">Name</label>
                    <input type="text" name="st_name" value="<?php echo $user->st_name ?>" class="form-control" id="st_name" placeholder="Username">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" value="<?php echo $user->password ?>" class="form-control" id="password" placeholder="Password">
                </div>
                <input type="hidden" name="id" value="<?php echo $user->id ?>" />
                <input type="submit" name="submit" class="btn btn-default" value="Update user" />
            </form>
        </div>
    </div>
</body>
</html>