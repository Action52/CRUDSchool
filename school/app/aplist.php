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
        if (empty($_POST['submit']))
{
      header("Location:" . logscheme::baseurl() . "app/verification.php");
      exit;
}

$args = array(
    'id_teacher'  => FILTER_SANITIZE_NUMBER_INT,

);
 $db = new Database;
        $user = new logscheme($db);

$post = (object)filter_input_array(INPUT_POST, $args);
$user->setid_teacher($post->id_teacher);

echo $post->id_teacher;

        $users = $user->get($post->id_teacher);


        ?>
        <div class="container">
            <div class="col-lg-12">
                <h2 class="text-center text-primary">Apointment list by month</h2>
                <div class="col-lg-1 pull-right" style="margin-bottom: 10px">
                    <a class="btn btn-info" href="<?php echo logscheme::baseurl() ?>/app/verification.php">Add apointment</a>
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
        if (empty($_POST['submit']))
{
      header("Location:" . logscheme::baseurl() . "app/verification.php");
      exit;
}

$args = array(
    'id_teacher'  => FILTER_SANITIZE_NUMBER_INT,

);
 $db = new Database;
        $user = new logscheme($db);

$post = (object)filter_input_array(INPUT_POST, $args);
$user->setid_teacher($post->id_teacher);

echo $post->id_teacher;

        $users = $user->getmonth($post->id_teacher);


        ?>

        <div class="container">
            <div class="col-lg-12">
                <h2 class="text-center text-primary">Apointment list by week</h2>
                <div class="col-lg-1 pull-right" style="margin-bottom: 10px">
                    <a class="btn btn-info" href="<?php echo logscheme::baseurl() ?>/app/verification.php">Add apointment</a>
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

<a href = "../index.php">Go to index</a>

                </div>










    </body>
</html>
