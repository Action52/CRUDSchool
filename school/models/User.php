<?php
require_once("../db/Database.php");
require_once("../interfaces/IUser.php");

class User implements IUser {
	private $con;
    private $id;
    private $id_student;
    private $id_teacher;
    private $id_subject;
    private $id_tutoring;
    private $topic;
    private $date;

	public function __construct(Database $db){
		$this->con = new $db;
	}

    public function setId($id){
        $this->id = $id;
    }

    public function setid_teacher($id_teacher){
        $this->id_teacher = $id_teacher;
    }

    public function setid_student($id_student){
        $this->id_student = $id_student;
    }
    public function setid_subject($id_subject){
        $this->id_subject = $id_subject;
    }
    public function setid_tutoring($id_tutoring){
        $this->id_tutoring = $id_tutoring;
    }
    public function settopic($topic){
        $this->topic = $topic;
    }
    public function setdate($date){
        $this->date = $date;
    }

	//insertamos usuarios en una tabla con postgreSql
	public function save() {
		try{
			$query = $this->con->prepare('INSERT INTO student_requests_tutoring (id_student,id_teacher,id_subject,id_tutoring,topic,date) values (?,?,?,?,?,?)');
            $query->bindParam(1, $this->id_student, PDO::PARAM_STR);
			$query->bindParam(2, $this->id_teacher, PDO::PARAM_STR);
             $query->bindParam(3, $this->id_subject, PDO::PARAM_STR);
            $query->bindParam(4, $this->id_tutoring, PDO::PARAM_STR);
             $query->bindParam(5, $this->topic, PDO::PARAM_STR);
            $query->bindParam(6, $this->date, PDO::PARAM_STR);
			$query->execute();
			$this->con->close();
		}
        catch(PDOException $e) {
	        echo  $e->getMessage();
	    }
	}

    public function update(){
		try{
			$query = $this->con->prepare('UPDATE student_requests_tutoring SET id_student = ?, id_teacher = ?, id_subject = ?, id_tutoring = ?, topic = ?, date = ? WHERE id = ?');
			 $query->bindParam(1, $this->id_student, PDO::PARAM_INT);
            $query->bindParam(2, $this->id_teacher, PDO::PARAM_INT);
             $query->bindParam(3, $this->id_subject, PDO::PARAM_INT);
            $query->bindParam(4, $this->id_tutoring, PDO::PARAM_INT);
             $query->bindParam(5, $this->topic, PDO::PARAM_STR);
            $query->bindParam(6, $this->date, PDO::PARAM_STR);
            $query->bindParam(7, $this->id, PDO::PARAM_INT);
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
                $query = $this->con->prepare('SELECT * FROM student_requests_tutoring WHERE id = ?');
                $query->bindParam(1, $this->id, PDO::PARAM_INT);
                $query->execute();
    			$this->con->close();
    			return $query->fetch(PDO::FETCH_OBJ);
            }
            else{
                $query = $this->con->prepare('SELECT student_requests_tutoring.id, student.st_name, teacher.te_name, subject.name, academic_consulting_hours.start_hour,student_requests_tutoring.topic,student_requests_tutoring.date
 FROM student_requests_tutoring
 INNER JOIN student ON student_requests_tutoring.id_student = student.id
 INNER JOIN teacher ON student_requests_tutoring.id_teacher = teacher.id
 INNER JOIN subject ON student_requests_tutoring.id_subject = subject.id
 INNER JOIN academic_consulting_hours ON student_requests_tutoring.id_tutoring = academic_consulting_hours.id
 ORDER BY id;');
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
            $query = $this->con->prepare('DELETE FROM student_requests_tutoring WHERE id = ?');
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
            header("Location:" . User::baseurl() . "app/list.php");
        }
    }
}
?>
