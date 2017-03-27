
<?php
include('../session.php');



?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Listado de usuarios</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
</head>
<body>
    <?php
    require_once "../models/Teacher.php";
    ?>
    <div class="container">
        <div class="col-lg-12">
            <h2 class="text-center text-primary">Add teacher</h2>
            <form action="<?php echo Teacher::baseurl() ?>app/teachersave.php" method="POST">
                <div class="form-group">
                    <label for="te_name">Name</label>
                    <input type="text" name="te_name" value="" class="form-control" id="te_name" placeholder="name">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" value="" class="form-control" id="password" placeholder="Password">
                </div>
                <input type="submit" name="submit" class="btn btn-default" value="Save user" />
            </form>
        </div>
    </div>
</body>
</html>