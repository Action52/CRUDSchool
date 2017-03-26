<?php
require_once("../db/Database.php");
require_once("../interfaces/IUser.php");

class logscheme  {
	private $con;
    private $id;
    private $id_teacher;


	public function __construct(Database $db){
		$this->con = new $db;
	}

    public function setId($id){
        $this->id = $id;
    }

    public function setid_teacher($id_teacher){
        $this->id_teacher = $id_teacher;
    }


	//insertamos usuarios en una tabla con postgreSql
	public function save() {

	}

    public function update(){

	}

	//obtenemos usuarios de una tabla con postgreSql
	public function get($id_teacher){
		try{

                $query = $this->con->prepare('SELECT student_requests_tutoring.id, student.st_name, teacher.te_name, subject.name, academic_consulting_hours.start_hour,student_requests_tutoring.topic,student_requests_tutoring.date
 FROM student_requests_tutoring
 INNER JOIN student ON student_requests_tutoring.id_student = student.id
 INNER JOIN teacher ON student_requests_tutoring.id_teacher = teacher.id
 INNER JOIN subject ON student_requests_tutoring.id_subject = subject.id
 INNER JOIN academic_consulting_hours ON student_requests_tutoring.id_tutoring = academic_consulting_hours.id
 WHERE student_requests_tutoring.id_teacher = :parameter
  AND Extract(month from student_requests_tutoring.date) = Extract(month from now())');
                $query->bindParam(':parameter', $id_teacher, PDO::PARAM_INT);
                $query->execute();
    			$this->con->close();
    			return $query->fetchAll(PDO::FETCH_OBJ);

		}
        catch(PDOException $e){
	        echo  $e->getMessage();
	    }
	}



    public function getmonth($id_teacher){
        try{

                $query = $this->con->prepare('SELECT student_requests_tutoring.id, student.st_name, teacher.te_name, subject.name, academic_consulting_hours.start_hour,student_requests_tutoring.topic,student_requests_tutoring.date
 FROM student_requests_tutoring
 INNER JOIN student ON student_requests_tutoring.id_student = student.id
 INNER JOIN teacher ON student_requests_tutoring.id_teacher = teacher.id
 INNER JOIN subject ON student_requests_tutoring.id_subject = subject.id
 INNER JOIN academic_consulting_hours ON student_requests_tutoring.id_tutoring = academic_consulting_hours.id
 WHERE student_requests_tutoring.id_teacher = :parameter
  AND Extract(week from student_requests_tutoring.date) <= Extract(week from now())');
                $query->bindParam(':parameter', $id_teacher, PDO::PARAM_INT);
                $query->execute();
                $this->con->close();
                return $query->fetchAll(PDO::FETCH_OBJ);

        }
        catch(PDOException $e){
            echo  $e->getMessage();
        }
    }


		public function getSpecific($id_teacher, $startDate, $endDate){
				try{

								$query = $this->con->prepare("SELECT student_requests_tutoring.id, student.st_name, teacher.te_name,
								  subject.name, academic_consulting_hours.start_hour, academic_consulting_hours.end_hour,
								  student_requests_tutoring.topic, student_requests_tutoring.date
								FROM
								  student_requests_tutoring, student, teacher, subject, academic_consulting_hours
								WHERE
								  student.id = student_requests_tutoring.id_student AND
								  teacher.id = student_requests_tutoring.id_teacher AND
								  subject.id = student_requests_tutoring.id_subject AND
								  academic_consulting_hours.id = student_requests_tutoring.id_tutoring AND
								  student_requests_tutoring.date >= '$startDate' AND
								  student_requests_tutoring.date <= '$endDate';
								");
								$query->execute();
								$this->con->close();
								return $query->fetchAll(PDO::FETCH_OBJ);

				}
				catch(PDOException $e){
						echo  $e->getMessage();
				}
		}










    public function delete(){

    }

    public static function baseurl() {
         return stripos($_SERVER['SERVER_PROTOCOL'],'https') === true ? 'https://' : 'http://' . $_SERVER['HTTP_HOST'] . "/2doParcial/CRUDSchool/school/";
    }

    public function checkUser($user) {
        if( ! $user ) {
            header("Location:" . logscheme::baseurl() . "app/aplist.php");
        }
    }
}
?>
