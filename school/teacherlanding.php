<?php
include('session.php');



?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Apointment list</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
    </head>
    <body>

        <div class="container">
            <div class="col-lg-12">
                <h2 class="text-center text-primary">Bienvenido profesor</h2>
                <div class= "text-right">
                 <b id="logout"><a href="logout.php">Log Out</a></b>
                </div>
                <div class="col-lg-12" style="margin-bottom: 10px">

                    <?php
                        $id= $_SESSION['id'];
                        $_SESSION['id'] = $id;

                    ?>

                    <a href = "app/aplist.php"> Verificar mis asesorias </a>
                    <br><br>
                    <a href = "setclasshours.php"> Fijar horas de clase </a>
                    <br><br>
                    <a href = "settutoring.php"> Fijar horas de asesorias</a>






                </div>

                <center><img src = "img/profesor.jpg"></center>
            </div>

    </body>
</html>
