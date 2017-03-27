<?php
//AQUI CONECTAMOS A LA BASE DE DATOS DE POSTGRES
$conex = "host=localhost port=5432 dbname=tutoringnew user=postgres password=";
$cnx = pg_connect($conex) or die ("<h1>Error de conexion.</h1> ". pg_last_error());
session_start();

function quitar($mensaje)
{
 $nopermitidos = array("'",'\\','<','>',"\"");
 $mensaje = str_replace($nopermitidos, "", $mensaje);
 return $mensaje;
}


$username = $_POST['username'];
$password = $_POST['password'];
if(trim($_POST["username"]) != "" && trim($_POST["password"]) != "")
{
 // Puedes utilizar la funcion para eliminar algun caracter en especifico
 //$user = strtolower(quitar($HTTP_POST_VARS["user"]));
 //$password = $HTTP_POST_VARS["password"];
 // o puedes convertir los a su entidad HTML aplicable con htmlentities
 $user = strtolower(htmlentities($_POST["username"], ENT_QUOTES));
 $password = $_POST["password"];
 $password = md5($password);
 $result = pg_query('SELECT username,password, type FROM login WHERE username=\''.$username.'\'');
 if($row = pg_fetch_array($result)){
  if($row["password"] == $password){
  	if($row["type"] == 0)
  		$_SESSION['login_user']=$username;
  		header("Location: adminlanding.php");
  	if($row["type"] == 1){
  		$_SESSION['login_user']=$username;
  		header("Location: teacherlanding.php");
      $result = pg_query('SELECT id FROM teacher WHERE te_name = \''.$username.'\'');

      if($row =  pg_fetch_array($result)){
      $id = $row["id"];

      $_SESSION['id'] = $id;
      
    }
    }
 
  	if($row["type"] == 2){
      $_SESSION['login_user']=$username;
  		header("Location: app/list.php");
        

        $result = pg_query('SELECT id FROM student WHERE st_name = \''.$username.'\'');

      if($row =  pg_fetch_array($result)){
      $id = $row["id"];

      $_SESSION['id'] = $id;
      
    }










//die();
  	}
   echo '<a href="index.php">Index</a></p>';
   //Elimina el siguiente comentario si quieres que re-dirigir automáticamente a index.php
   /*Ingreso exitoso, ahora sera dirigido a la pagina principal.
   <SCRIPT LANGUAGE="javascript">
   location.href = "index.php";
   </SCRIPT>*/
  }else{
   echo 'Password incorrecto';
   header("index.html");

  }
 }else{
  echo 'user no existente en la base de datos';
 }
 pg_free_result($result);
}else{
 echo 'Debe especificar un user y password';
}
pg_close();
?>