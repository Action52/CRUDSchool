<?php
include('session.php');



?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Admin</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
    </head>
    <body>
        
        <div class="container">
            <div class="col-lg-12">
                <h2 class="text-center text-primary">Bienvenido Admin</h2>
                <div class="col-lg-1" style="margin-bottom: 10px">


                    <a href = "app/studentlist.php">Estudiantes</a>

                    <a href = "app/teacherlist.php">Profesores</a>





                    
                </div>


                 <b id="logout"><a href="logout.php">Log Out</a></b> 
</div>
              
    </body>
</html>