<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Listado de usuarios</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
</head>
<body>
    <?php
    require_once "../models/logscheme.php";
    ?>
    <div class="container">
        <div class="col-lg-12">
            <h2 class="text-center text-primary">enter your teacher id</h2>
            <form action="<?php echo logescheme::baseurl() ?>app/savelog.php" method="POST">
                <div class="form-group">
                    <label for="id_teacher">id_teacher</label>
                    <input type="int" name="id_teacher" value="" class="form-control" id="id_teacher" placeholder="id_teacher">
                </div>

                <input type="submit" name="submit" class="btn btn-default" value="Save user" />
            </form>
        </div>
    </div>
</body>
</html>