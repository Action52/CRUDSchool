<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Register</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
</head>
<body>
  <?php
    require_once "Teacher.php";
    require_once "Admin.php";
  ?>
    <div class="container">
        <div class="col-lg-12">
          <?php
          $db = new Database;
          $user = new Teacher($db);
          ?>
            <h2 class="text-center text-primary">Register</h2>
          <form action="reg.php" method="POST">
                <div class="form-group">
                    <label for="subjectname">Name</label>
                    <input type="text" name="subjectname" value="" class="form-control" id="subjectname" placeholder="Name">
                </div>
                <div class="form-group">
                    <label for="start">Password</label>
                    <input type="password" name="pswd" value="" class="form-control" id="pswd" placeholder="Password">
                </div>
                <div class="form-group">
                    <label for="start">Mail</label>
                    <input type="text" name="mail" value="" class="form-control" id="mail" placeholder="AXXXXXXX | LXXXXXXXX @itesm.mx ">
                </div>
                <input type="submit" name="submitBtn" class="btn btn-default" value="Register" />
            </form>

        </div>
    </div>


</body>
</html>
