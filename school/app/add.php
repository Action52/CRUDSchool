
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
    require_once "../models/User.php";
    ?>
    <div class="container">
        <div class="col-lg-12">
            <h2 class="text-center text-primary">Add apointment</h2>
            <form action="<?php echo User::baseurl() ?>app/save.php" method="POST">
                <div class="form-group">
                    <label for="id_student">id_student</label>
                    <input type="int" name="id_student" value="" class="form-control" id="id_student" placeholder="id_student">
                </div>
                <div class="form-group">
                    <label for="id_student">tutoring</label>
                    <?php

                    $conex = "host=localhost port=5432 dbname=tutoringnew user=postgres password=";
                    $cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
                    $query = "SELECT * FROM asesorias";
$result = pg_query($cnx, $query) or die("Error in query: $query." . pg_last_error($connection));



if (pg_num_rows($result) == 0) 
{
    echo "Currently no appointments.<br/>";
}
else
{
    while ($myrow = pg_fetch_row($result)) 
    {
        echo "<input type='radio' name='id_teacher' value='" . $myrow[0] . "'/>" .  $myrow[1]."-".$myrow[2] ."-". $myrow[3] ."<br/>";
    }
}


pg_close($cnx);
                    ?>
                </div>



                 <div class="form-group">
                    <label for="id_subject">subject</label>
                    <select name="id_subject" Id="id_subject">
 <option value="">--- Select ---</option>
                    <?php

                    $conex = "host=localhost port=5432 dbname=tutoringnew user=postgres password=";
                    $cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
                

 $list = pg_query($cnx, "select * from subject ");

 

 while($row_list=pg_fetch_assoc($list)){
 ?>
 <option value=<?php echo $row_list["id"]; ?>>
 <?php echo $row_list["name"]; ?> 
 </option>
 <?php
 }
 ?>
 </select>
 


                    
                </div>

                <div class="form-group">
                    <label for="topic">topic</label>
                    <input type="text" name="topic" value="" class="form-control" id="topic" placeholder="topic">
                </div>
                <div class="form-group">
                    <label for="date">date</label>
                    <input type="date" name="date" value="" class="form-control" id="date" placeholder="date">
                </div>
                <input type="submit" name="submit" class="btn btn-default" value="Save user" />
            </form>
        </div>
    </div>
</body>
</html>