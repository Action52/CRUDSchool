<?php
require_once("Database.php");

class Teacher{
	private $con;
    public $id;
    private $username;
    private $password;
    private $department;
		public $n_classes;



	public function __construct(Database $db){
		$this->con = new $db;
	}

		public function setNClasses($n){
			$this->n_classes = $n;
		}
    public function setId($id){
        $this->id = $id;
    }

		public function getId(){
			return $this->id;
		}

    public function setUsername($username){
        $this->username = $username;
    }

    public function setPassword($password){
        $this->password = $password;
    }

    public function setDepartment($department){
        $this->department= $department;
    }

	//insertamos profesores en una tabla con postgreSql
	public function save() {
		try{
			$query = $this->con->prepare('INSERT INTO teacher(te_name, password, department) values (?,?,?)');
            $query->bindParam(1, $this->username, PDO::PARAM_STR);
			$query->bindParam(2, $this->password, PDO::PARAM_STR);
      $query->bindParam(3, $this->department, PDO::PARAM_STR);
			$query->execute();
			$this->con->close();
		}
        catch(PDOException $e) {
	        echo  $e->getMessage();
	    }
	}


	//Inserta una clase nueva
	public function add_class($idClass){
		try{
			$query = $this->con->prepare("SELECT id FROM teacher_class WHERE id_teacher = '$this->id' AND id_class = '$idClass'");
			$result = $query->execute();
			$statement = $query->fetch();
			if($statement){ //Si existe la relacion...

			}
			else{
				$query = $this->con->prepare("INSERT INTO teacher_class(id_teacher, id_class)
				values ('$this->id',
					'$idClass'
				)");
				$query->execute();
				$this->con->close();
			}
		}
        catch(PDOException $e) {
	        echo  $e->getMessage();
	    }
	}

	//Inserta un tutoring nuevo
	public function add_tutoring($idTutoring,$av){
		try{
			$query = $this->con->prepare("SELECT id FROM teacher_has_tutoring_hours WHERE id_teacher = '$this->id' AND id_tutoring = '$idTutoring'");
			$result = $query->execute();
			$statement = $query->fetch();
			if($statement){ //Si existe la relacion...

			}
			else{
				$query = $this->con->prepare("INSERT INTO teacher_has_tutoring_hours(id_teacher, id_tutoring, available)
					values ('$this->id','$idTutoring', '$av')");
				$query->execute();
				$this->con->close();
			}
		}
				catch(PDOException $e) {
					echo  $e->getMessage();
			}
	}

	//Inserta una subject nuevo
	public function add_subject($idSubject){
		try{
			$query = $this->con->prepare("SELECT id FROM teacher_subject WHERE id_teacher = '$this->id' AND id_subject = '$idSubject'");
			$result = $query->execute();
			$statement = $query->fetch();
			if($statement){ //Si existe la relacion...no hago nada

			}
			else{
				$query = $this->con->prepare("INSERT INTO teacher_subject(id_teacher, id_subject)
				values ('$this->id',
					'$idSubject'
				)");
				$query->execute();
				$this->con->close();
			}
		}
        catch(PDOException $e) {
	        echo  $e->getMessage();
	    }
	}

    public function update(){
		try{
			$query = $this->con->prepare('UPDATE teacher SET te_name = ?, password = ? , department = ? WHERE id = ? ');
			$query->bindParam(1, $this->username, PDO::PARAM_STR);
			$query->bindParam(2, $this->password, PDO::PARAM_STR);
      $query->bindParam(3, $this->department, PDO::PARAM_STR);
      $query->bindParam(4, $this->id, PDO::PARAM_INT);
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
                $query = $this->con->prepare('SELECT * FROM teacher WHERE id = ?');
                $query->bindParam(1, $this->id, PDO::PARAM_INT);
                $query->execute();
    			$this->con->close();
    			return $query->fetch(PDO::FETCH_OBJ);
            }
            else{
                $query = $this->con->prepare('SELECT * FROM teacher');
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
            $query = $this->con->prepare('DELETE FROM teacher WHERE id = ?');
            $query->bindParam(1, $this->id, PDO::PARAM_INT);
            $query->execute();
            $this->con->close();
            return true;
        }
        catch(PDOException $e){
            echo  $e->getMessage();
        }
    }

		public function registerClasses(){
			try{
					$query = $this->con->prepare("INSERT INTO teacher_period(id_teacher, id_period)
						VALUES('$this->id', 3)");
					$query->execute();
					$this->con->close();
			}
			catch(PDOException $e){
					echo  $e->getMessage();
			}
		}

    public static function baseurl() {
         return stripos($_SERVER['SERVER_PROTOCOL'],'https') === true ? 'https://' : 'http://' . $_SERVER['HTTP_HOST'] . "/2doParcial/CRUDSchool/school/";
    }

    public function checkUser($user) {
        if( ! $user ) {
            header("Location:" . Teacher::baseurl() . "index.php");
        }
    }
}
?>
