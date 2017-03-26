<?php
include('../session.php');
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Apointment list</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
    </head>
    <body>
        <?php
        require_once "../models/User.php";
        $db = new Database;
        $user = new User($db);
        $users = $user->get();
        $id = $_SESSION['id'];
        echo $id;
        ?>
        <div class="container">
            <div class="col-lg-12">
                <h2 class="text-center text-primary">Appointments list</h2>
                <div class="col-lg-1 pull-right" style="margin-bottom: 10px">
                    <a class="btn btn-info" href="<?php echo User::baseurl() ?>/app/add.php">Add apointment</a>
                </div>
                <?php
                if( ! empty( $users ) )
                {
                ?>
                <table class="table table-striped">
                    <tr>
                        <th>Id</th>
                        <th>student name</th>
                        <th>teacher name</th>
                        <th>subject</th>
                        <th>start hour</th>
                        <th>topic</th>
                        <th>date</th>
                    </tr>
                    <?php foreach( $users as $user )
                    {
                    ?>


                        <tr>
                            <td><?php echo $user->id ?></td>
                            <td><?php echo $user->st_name ?></td>
                            <td><?php echo $user->te_name ?></td>
                            <td><?php echo $user->name ?></td>
                            <td><?php echo $user->start_hour ?></td>
                            <td><?php echo $user->topic ?></td>
                            <td><?php echo $user->date ?></td>
                            <td>
                                <a class="btn btn-info" href="<?php echo User::baseurl() ?>app/edit.php?user=<?php echo $user->id ?>">Edit</a>
                                <a class="btn btn-info" href="<?php echo User::baseurl() ?>app/delete.php?user=<?php echo $user->id ?>">Delete</a>
                            </td>
                        </tr>
                    <?php
                    }
                    ?>
                </table>
                <b id="logout"><a href="../logout.php">Log Out</a></b> 
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
