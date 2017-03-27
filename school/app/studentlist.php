<?php
include('../session.php');
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Estudiantes</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
    </head>
    <body>
        <?php
        require_once "../models/Student.php";

 $db = new Database;
        $user = new Student($db);
        $users = $user->get();
        ?>
        <div class="container">
            <div class="col-lg-12">
                <h2 class="text-center text-primary">Lista de estudiantes</h2>
                <a class="btn btn-info" href="<?php echo Student::baseurl() ?>/app/addstudent.php">Agregar estudiante</a>
               

                <?php
                if( ! empty( $users ) )
                {
                ?>
                <table class="table table-striped">
                    <tr>
                        <th>Id</th>
                        <th>Nombre</th>
                        <th>password</th>
                    </tr>
                    <?php foreach( $users as $user )
                    {
                    ?>
                        <tr>
                            <td><?php echo $user->id ?></td>
                            <td><?php echo $user->st_name ?></td>
                            <td><?php echo $user->password ?></td>
                            <td>
                                <a class="btn btn-info" href="<?php echo Student::baseurl() ?>app/editstudent.php?user=<?php echo $user->id ?>">Edit</a>
                                <a class="btn btn-info" href="<?php echo Student::baseurl() ?>app/deletestudent.php?user=<?php echo $user->id ?>">Delete</a>
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

        

<a href = "../adminlanding.php">Go to index</a>

                </div>










    </body>
</html>
