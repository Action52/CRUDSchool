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
        $db = new Database;
        $user = new Teacher($db);
        $users = $user->get();
        ?>
        <div class="container">
            <div class="col-lg-12">
                <h2 class="text-center text-primary">Teachers List</h2>
                <div class="col-lg-1 pull-right" style="margin-bottom: 10px">
                    <a class="btn btn-info" href="<?php echo Teacher::baseurl() ?>add.php">Add teacher</a>
                </div>
                <?php
                if( ! empty( $users ) )
                {
                ?>
                <table class="table table-striped">
                    <tr>
                        <th>Id</th>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Actions</th>
                    </tr>
                    <?php foreach( $users as $user )
                    {
                    ?>
                        <tr>
                            <td><?php echo $user->id ?></td>
                            <td><?php echo $user->te_name ?></td>
                            <td><?php echo $user->password ?></td>
                        
                            <td>
                                <?php $idTeacher = $user->id;
                                echo $idTeacher;?>
                                  <!--Send idTeacher parameter!-->
                                <form action="<?php echo Teacher::baseurl() ?>setclasshours.php?user=<?php echo $user->id ?>" method="POST">
                                  <input type="hidden" id = "idTeacher" name = "idTeacher" value ="<?php echo (isset($idTeacher))?$idTeacher:'';?>">

                                  <input type="submit" <input type="submit" name="submitBtn" class="btn btn-default" value="Set classes" />
                                </form>

                                <form action="<?php echo Teacher::baseurl() ?>settutoring.php?user=<?php echo $user->id ?>" method="POST">
                                  <input type="hidden" id = "idTeacher" name = "idTeacher" value ="<?php echo (isset($idTeacher))?$idTeacher:'';?>">
                                  <input type="submit" <input type="submit" name="submitBtn" class="btn btn-default" value="Set tutoring" />
                                </form>

                            </td>
                        </tr>
                    <?php
                    }
                    ?>
                </table>
                <?php
                }
                else
                {
                ?>
                <div class="alert alert-danger" style="margin-top: 100px">Any user has been registered</div>
                <?php
                }
                ?>
            </div>
        </div>
    </body>
</html>
