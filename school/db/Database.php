<?php

class Database extends PDO{

	//dbname
	private $dbname = "usuario2";
	//host
	private $host 	= "localhost";
	//user database
	private $user 	= "usuario2";
	//password user
	private $pass 	= 'd8be248b2a563a45a43222a250dcad042fba7c03e5';
	//port
	private $port 	= 5432;
    //instance
	private $dbh;

	//connect with postgresql and pdo
	public function __construct(){
	    try {
	        $this->dbh = parent::__construct("pgsql:host=$this->host;port=$this->port;dbname=$this->dbname;user=$this->user;password=$this->pass");
	    }
        catch(PDOException $e){
	        echo  $e->getMessage();
	    }
	}

	//función para cerrar una conexión pdo
	public function close(){
    	$this->dbh = null;
	}
}

?>
