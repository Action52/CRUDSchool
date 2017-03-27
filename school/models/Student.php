<?php
require_once("../Database.php");

class Student{
	private $con;
    public $id;
    private $st_name;
    private $password;


	public function __construct(Database $db){
		$this->con = new $db;
	}

    public function setId($id){
        $this->id = $id;
    }

		public function getId(){
			return $this->id;
		}

    public function setst_name($st_name){
        $this->st_name = $st_name;
    }

    public function setPassword($password){
        $this->password = $password;
    }

	//insertamos profesores en una tabla con postgreSql
	public function save() {
		try{
			
			
			$query = $this->con->prepare('INSERT INTO student(st_name, password) values (?,?)');
            $query->bindParam(1, $this->st_name, PDO::PARAM_STR);
			$query->bindParam(2, $this->password, PDO::PARAM_STR);
			$query->execute();
			$this->con->close();
		}
        catch(PDOException $e) {
	        echo  $e->getMessage();
	    }
	}


    public function update(){
		try{

			$query = $this->con->prepare('UPDATE student SET st_name = ?, password = ?  WHERE id = ? ');
			$query->bindParam(1, $this->st_name, PDO::PARAM_STR);
			$query->bindParam(2, $this->password, PDO::PARAM_STR);
      $query->bindParam(3, $this->id, PDO::PARAM_INT);
			$query->execute();
			$this->con->close();






		}
        catch(PDOException $e){
	        echo  $e->getMessage();
	    }
	}

	//obtenemos usuarios de una tabla con postgreSql
	public function get(){
		try{
            if(is_int($this->id)){
                $query = $this->con->prepare('SELECT * FROM student WHERE id = ?');
                $query->bindParam(1, $this->id, PDO::PARAM_INT);
                $query->execute();
    			$this->con->close();
    			return $query->fetch(PDO::FETCH_OBJ);
            }
            else{
                $query = $this->con->prepare('SELECT * FROM student');
    			$query->execute();
    			$this->con->close();
    			return $query->fetchAll(PDO::FETCH_OBJ);
            }
		}
        catch(PDOException $e){
	        echo  $e->getMessage();
	    }
	}

    public function delete(){
        try{
            $query = $this->con->prepare('DELETE FROM student WHERE id = ?');
            $query->bindParam(1, $this->id, PDO::PARAM_INT);
            $query->execute();
            $this->con->close();

            return true;
        }
        catch(PDOException $e){
            echo  $e->getMessage();
        }
    }


    public static function baseurl() {
         return stripos($_SERVER['SERVER_PROTOCOL'],'https') === true ? 'https://' : 'http://' . $_SERVER['HTTP_HOST'] . "/crudschool/";
    }

    public function checkUser($user) {
        if( ! $user ) {
            header("Location:" . Student::baseurl() . "index.php");
        }
    }
}
?>
