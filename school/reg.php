<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Add classes</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">

    <?php
      require_once "Admin.php";
      require_once "Teacher.php";

      $name = $_POST['name'];
      $pswd = $_POST['pswd'];
      $mail = $_POST['mail'];

      $db = new Database;
      $admin = new Admin($db);

      $valid = $admin->checkMail($mail);

      if($valid == 0){ //Es valido
        //Generar token
        $tkn = $admin->generateToken();
        $encrypt = md5($pswd);

        //Agregar token a la base
        $admin->addToken($mail, $encrypt, $tkn, $name);


        //Enviar mail con el token

        $msg = "Welcome to the tutoring system\n";
        $msg .= "Generated token: \n";
        $msg .= $tkn;

        $msg .= "\nOnce inserted into the system, you can login as user.";
        $msg .= "\n Thank you for your preference.";

        mail($mail,"Tutoring system", $msg);
      }
      else{
        echo "Mail no válido";
      }


      //Comprobar mail valido
      //Generar Token
      //Agregar el token a la base
      //Enviar mail con el token
        //Redirigir a página de ingreso de token y validación (EL USUARIO NUEVO SE GUARDA HASTA ESE MOMENTO)

    ?>

</head>
<body>
    <div class="container">
        <div class="col-lg-12">
            <h2 class="text-center text-primary">Token</h2>
            <h4>
              <br>Thanks for registring, <?php echo $name;?>!
              <br>We've sent you an email to <?php echo $mail;?> with a valid token to end your registration.
            </h4>
          <form action="confirm.php" method="POST">
                <div class="form-group">
                    <label for="token">Insert valid 16-character-long token: </label>
                    <input type="text" name="token" value="" class="form-control" id="token" placeholder="Token">
                </div>
                <input type = "hidden" name = "name" value = "<?php echo $name?>">
                <input type="submit" name="submitBtn" class="btn btn-default" value="Validate registration" />
            </form>

        </div>
    </div>


</body>
</html>
