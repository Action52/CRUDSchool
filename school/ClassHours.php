<?php
require_once("Database.php");

class ClassHours{
	private $con;
    private $id;
    private $start;
    private $end;
    private $days;

	public function __construct(Database $db){
		$this->con = new $db;
	}

    public function getId(){
      return $this->id;
    }

    public function setId($id){
        $this->id = $id;
    }

    public function setStart($start){
        $this->start = $start;
    }

    public function setEnd($end){
        $this->end = $end;
    }

    public function setDays($days){
        $this->days= $days;
    }

	//insertamos profesores en una tabla con postgreSql
	public function save() {
		try{
			$query = $this->con->prepare('INSERT INTO class_hours(start_hour, end_hour, days) values (?,?,?)');
            $query->bindParam(1, $this->start, PDO::PARAM_STR);
			$query->bindParam(2, $this->end, PDO::PARAM_STR);
      $query->bindParam(3, $this->days, PDO::PARAM_STR);
			$query->execute();
			$this->con->close();

			$this->id = $this->con->lastInsertID();
			$this->con->close();

		}
        catch(PDOException $e) {
	        echo  $e->getMessage();
	    }
	}


	//Inserta una clase nueva
	public function add_class($name, $start, $end, $days, $id){
		try{

			$query = $this->con->prepare('INSERT INTO class_hours(start_hours, end_hour, days) values (?,?,?)');
			$query->bindParam(1, $start, PDO::PARAM_STR);
      $query->bindParam(2, $end, PDO::PARAM_STR);
			$query->bindParam(3, $days, PDO::PARAM_STR);
			$query->execute();
			$this->con->close();


			$query = $this->con->prepare("INSERT INTO teacher_class(id_teacher, id_class)
			values ('$id',
				(SELECT id FROM class_hours WHERE name = '$name')
			)");
			$query->bindParam(1, $name, PDO::PARAM_INT);
			$query->bindParam(2, $start, PDO::PARAM_INT);
			$query->execute();
			$this->con->close();
		}
        catch(PDOException $e) {
	        echo  $e->getMessage();
	    }
	}



    public function update(){
		try{
			$query = $this->con->prepare('UPDATE teacher SET name = ?, password = ? , department = ? WHERE id = ? ');
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
                $query = $this->con->prepare('SELECT * FROM class_hours WHERE id = ?');
                $query->bindParam(1, $this->id, PDO::PARAM_INT);
                $query->execute();
    			$this->con->close();
    			return $query->fetch(PDO::FETCH_OBJ);
            }
            else{
                $query = $this->con->prepare('SELECT * FROM class_hours');
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
            $query = $this->con->prepare('DELETE FROM class_hours WHERE id = ?');
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
         return stripos($_SERVER['SERVER_PROTOCOL'],'https') === true ? 'https://' : 'http://' . $_SERVER['HTTP_HOST'] . "/ICA2/";
    }

    public function checkUser($user) {
        if( ! $user ) {
            header("Location:" . ClassHours::baseurl() . "index.php");
        }
    }
}
?>
