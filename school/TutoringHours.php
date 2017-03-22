<?php
require_once("Database.php");

class TutoringHours{
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
			$query = $this->con->prepare('INSERT INTO academic_consulting_hours(start_hour, end_hour, days) values (?,?,?)');
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

	//Revisa si esta tutoring hour ya existe
	public function check(){
		try{
			$query = $this->con->prepare("SELECT id FROM academic_consulting_hours WHERE start_hour = '$this->start' AND end_hour = '$this->end'
				AND days = '$this->days'");
			$result = $query->execute();
			$statement = $query->fetch();
			if($statement){ //Existe, entonces NO SE INSERTA, solo recopilaré la id
				$this->setId($statement[0]);
			}
			else{
				$query = $this->con->prepare('INSERT INTO academic_consulting_hours(start_hour, end_hour, days) values (?,?,?)');
							$query->bindParam(1, $this->start, PDO::PARAM_STR);
							$query->bindParam(2, $this->end, PDO::PARAM_STR);
							$query->bindParam(3, $this->days, PDO::PARAM_STR);
				$query->execute();
				$this->id = $this->con->lastInsertID();
				$this->con->close();
			}
		}
				catch(PDOException $e) {
					echo  $e->getMessage();
			}
	}

    public function update(){
		try{
			$query = $this->con->prepare('UPDATE academic_consulting_hours SET start_hour = ?, end_hour = ? , days = ? WHERE id = ? ');
			$query->bindParam(1, $this->start, PDO::PARAM_STR);
			$query->bindParam(2, $this->end, PDO::PARAM_STR);
      $query->bindParam(3, $this->days, PDO::PARAM_STR);
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
                $query = $this->con->prepare('SELECT * FROM academic_consulting_hours WHERE id = ?');
                $query->bindParam(1, $this->id, PDO::PARAM_INT);
                $query->execute();
    			$this->con->close();
    			return $query->fetch(PDO::FETCH_OBJ);
            }
            else{
                $query = $this->con->prepare('SELECT * FROM academic_consulting_hours');
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
            $query = $this->con->prepare('DELETE FROM academic_consulting_hours WHERE id = ?');
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
            header("Location:" . TutoringHours::baseurl() . "index.php");
        }
    }
}
?>
