<?php
require_once("Database.php");

class Subject{
	private $con;
    private $id;
    private $name;

	public function __construct(Database $db){
		$this->con = new $db;
	}

    public function setId($id){
        $this->id = $id;
    }

		public function getId(){
				return $this->id;
		}

    public function setName($name){
        $this->name = $name;
    }

	//insertamos en una tabla con postgreSql
	public function save() {
		try{
			$query = $this->con->prepare('INSERT INTO subject(name) values (?)');
            $query->bindParam(1, $this->name, PDO::PARAM_STR);
			$query->execute();
			$this->con->close();

			$this->id = $this->con->lastInsertID();
			$this->con->close();
		}
        catch(PDOException $e) {
	        echo  $e->getMessage();
	    }
	}

	//Revisa si el subject ya existe
	public function check(){
		try{
			$query = $this->con->prepare("SELECT id FROM subject WHERE name = '$this->name'");
			$result = $query->execute();
			$statement = $query->fetch();
			if($statement){ //Existe, entonces NO SE INSERTA, solo recopilaré la id
				$this->setId($statement[0]);
			}
			else{
				$query = $this->con->prepare('INSERT INTO subject(name) values (?)');
	            $query->bindParam(1, $this->name, PDO::PARAM_STR);
				$query->execute();
				$this->con->close();

				$this->id = $this->con->lastInsertID();
				$this->con->close();
			}
		}
				catch(PDOException $e) {
					echo  $e->getMessage();
			}
	}

	//Inserta una clase nueva
	public function add_class($name, $start, $end, $days){
		try{

			$query = $this->con->prepare('INSERT INTO class_hours(name, start_hours, end_hour, days) values (?,?,?,?)');
            $query->bindParam(1, $name, PDO::PARAM_STR);
			$query->bindParam(2, $start, PDO::PARAM_STR);
      $query->bindParam(3, $end, PDO::PARAM_STR);
			$query->bindParam(4, $days, PDO::PARAM_STR);
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
			$query = $this->con->prepare('UPDATE subject SET name = ? WHERE id = ? ');
			$query->bindParam(1, $this->name, PDO::PARAM_STR);
      $query->bindParam(2, $this->id, PDO::PARAM_INT);
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
                $query = $this->con->prepare('SELECT * FROM subject WHERE id = ?');
                $query->bindParam(1, $this->id, PDO::PARAM_INT);
                $query->execute();
    			$this->con->close();
    			return $query->fetch(PDO::FETCH_OBJ);
            }
            else{
                $query = $this->con->prepare('SELECT * FROM subject');
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
            $query = $this->con->prepare('DELETE FROM subject WHERE id = ?');
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
            header("Location:" . Subject::baseurl() . "index.php");
        }
    }
}
?>
