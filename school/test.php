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


?>
</body>
</html>
