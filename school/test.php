<html>
<body>
<?php
  require_once "Admin.php";
  $db = new Database;
  $admin = new Admin($db);
  for($i = 0; $i < 20; $i++){
    $tkn = $admin->generateToken();
    echo $tkn;
    echo "<br>";
  }

  echo $admin->checkMail("L0132223@itesm.mx");
  echo "<br>";
  echo $admin->checkMail("A01322275@itesm.mx");
  echo "<br>";
  echo $admin->checkMail("R0132223@itesm.mx");
  echo "<br>";
?>
</body>
</html>
