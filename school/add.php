<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Listado de usuarios</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
</head>
<body>
    <?php
    require_once "Teacher.php";
    ?>
    <div class="container">
        <div class="col-lg-12">
            <h2 class="text-center text-primary">Add Teacher</h2>
            <form action="<?php echo Teacher::baseurl() ?>save.php" method="POST">
                <div class="form-group">
                    <label for="username">Name</label>
                    <input type="text" name="username" value="" class="form-control" id="username" placeholder="Username">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" value="" class="form-control" id="password" placeholder="Password">
                </div>
                <div class="form-group">
                    <label for="password">Department</label>
                    <input type="text" name="department" value="" class="form-control" id="department" placeholder="Department">
                </div>
                <input type="submit" name="submit" class="btn btn-default" value="Save teacher" />
            </form>
        </div>
    </div>
</body>
</html>
