<?php
include('session.php');



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
            <h2 class="text-center text-primary">Set class hours</h2>
            <?php echo $_SESSION['id'];?>
            <form action = "<?php echo Teacher::baseurl() ?>setclass.php" method = "POST">
            <input type="hidden" id = "idTeacher" name = "idTeacher" value ="<?php echo $_SESSION['idTeacher']?>">
            <br>
            <input type="submit" name="submit" class="btn btn-default" value="Create classes" />
            </form>
        </div>
    </div>
</body>
</html>
