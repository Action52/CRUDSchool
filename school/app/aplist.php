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
        require_once "../models/logscheme.php";

 $db = new Database;
        $user = new logscheme($db);

        $id = $_SESSION['id'];
$user->setid_teacher($id);


        $users = $user->get($id);


        ?>
        <div class="container">
            <div class="col-lg-12">
                <h2 class="text-center text-primary">Apointment list by month</h2>


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

        <?php
        require_once "../models/logscheme.php";
 $db = new Database;
        $user = new logscheme($db);

        $id = $_SESSION['id'];
$user->setid_teacher($id);


        $users = $user->getmonth($id);


        ?>

        <div class="container">
            <div class="col-lg-12">
                <h2 class="text-center text-primary">Apointment list by week</h2>


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

                <div class="container">
                    <div class="col-lg-12">
                        <h2 class="text-center text-primary">Apointment list personalized</h2>
                        <form action = "<?php echo logscheme::baseurl()?>app/listpersonalized.php" method = "POST">
                        <input type="hidden" id = "idTeacher" name = "idTeacher" value ="<?php echo $_SESSION['id']?>">
                        <br>
                        <input type="date" id = "startDate" name = "startDate" value ="" class = "form-control">
                        <input type="date" id = "endDate" name = "endDate" value ="" class = "form-control">
                        <br>
                        <input type="submit" name="submit" class="btn btn-default" value="Personalize search" />
                        </form>
                        </div>
                        <br><br>
                <a href = "../index.php">Go to index</a>

                        </div>







    </body>
</html>
