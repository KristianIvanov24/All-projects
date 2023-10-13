<?php

require_once('ScheduleTable.php');
require_once('Schedule.php');
require_once('RequestHandler.php');
require_once('GoingSchedule.php');

class ScheduleQueries {
	public static function CreateSchedule(ScheduleTable $schedule, ?PDO $connection = null): ?int {
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$statement = $connection->prepare("INSERT INTO `schedules` (title, date, schedule_start, schedule_end, schedule_step, created_by) 
										   VALUES (:title, :date, :schedule_start, :schedule_end, :schedule_step, :created_by)");
		$scheduleData = $schedule->jsonSerialize();
	
		return $statement->execute([
				'title' => $scheduleData['title'],
				'date' => $scheduleData['date'],
				'schedule_start' => $scheduleData['schedule_start'],
				'schedule_end' => $scheduleData['schedule_end'],
				'schedule_step' => $scheduleData['schedule_step'],
				'created_by' => $scheduleData['created_by']
		]) ? $connection->lastInsertId('id') : null;
	}
	
	public static function GetAllSchedules(?PDO $connection = null): array {
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$result = [];
		$statement = $connection->prepare("SELECT * FROM `schedules`");
		$statement->execute();
		
		$i = 0;
		while($row = $statement->fetch())
			$result[$i++] = $row;
		
		return $result;
	}
	
	public static function GetScheduleById(int $id, ?PDO $connection = null): array {
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$statement = $connection->prepare("SELECT * FROM `schedules` WHERE id = :id");
		$statement->execute(['id' => $id]);
		
		return $statement->fetch();
	}
	
	public static function GetScheduleRecordByKey(int $schedule_id, int $slot_number, ?PDO $connection = null): array {
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$statement = $connection->prepare("SELECT * FROM `schedule_records` WHERE schedule_id = :schedule_id AND slot_number = :slot_number");
		$statement->execute(['schedule_id' => $schedule_id, 'slot_number' => $slot_number]);
		
		return $statement->fetch();
	}
	
	public static function GetScheduleRecords(int $schedule_id, ?PDO $connection = null): array {
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$result = [];
		$statement = $connection->prepare("SELECT * FROM `schedule_records` WHERE schedule_id = :schedule_id ORDER BY slot_number");
		$statement->execute(['schedule_id' => $schedule_id]);
		$i = 0;
		while($row = $statement->fetch())
			$result[$i++] = $row;
		
		return $result;
	}

	public static function GetGoingRecords(int $id, ?PDO $connection = null): array {
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$result = [];
		$statement = $connection->prepare("SELECT * FROM `going` WHERE id = :id");
		$statement->execute(['id' => $id]);
		$i = 0;
		while($row = $statement->fetch())
			$result[$i++] = $row;
		
		return $result;
	}

	public static function AddScheduleRecord(Schedule $sr, ?PDO $connection = null): bool {
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$statement = $connection->prepare("INSERT INTO `schedule_records` (schedule_id, slot_number, presenter_id, presentation_title, specialty, course, `group`) " .
										  "SELECT :schedule_id, :slot_number, :presenter_id, :presentation_title, :specialty, :course, :group " .
										  "FROM (SELECT COUNT(*) AS cnt FROM `schedule_records` WHERE schedule_id = :schedule_id 
										  				AND presenter_id = :presenter_id) as T, " .
										  "	  	(SELECT COUNT(*) AS cnt FROM `users` WHERE `users`.id = :presenter_id 
										  				AND `users`.type = 'ADMIN') as U " .
										  "WHERE (T.cnt < :MAX_PRESENTATIONS OR U.cnt > 0)");
       // var_dump($statement);
		$config = parse_ini_file('../config/project.ini', true);
        //var_dump($config);
		$scheduleData = $sr->jsonSerialize();
        //var_dump($scheduleData);

		return $statement->execute([
				'schedule_id' => $scheduleData['schedule_id'],
				'slot_number' => $scheduleData['slot_number'],
				'presenter_id' => $scheduleData['presenter_id'],
				'presentation_title' => $scheduleData['presentation_title'],
				'specialty' => $scheduleData['specialty'],
				'course' => $scheduleData['course'],
				'group' => $scheduleData['group']
		] + ['MAX_PRESENTATIONS' => $config['app']['MAX_PRESENTATIONS']]);
	}

	public static function AddGoingRecord(GoingSchedule $sr, ?PDO $connection = null): bool {
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$statement = $connection->prepare("INSERT INTO `going` (user_id, schedule_id, title, date) " . 
										  "VALUES (:user_id, :schedule_id, :presentation_title, :date)");
		
		return $statement->execute($sr->jsonSerialize());
	}

	public static function UpdateScheduleRecord(Schedule $sr, ?PDO $connection = null): bool {
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$statement = $connection->prepare("UPDATE `schedule_records` sr, ( SELECT id FROM `users` WHERE type = 'ADMIN' ) as adm " .
										  "SET sr.presentation_title = :presentation_title, sr.specialty = :specialty, 
										  	   sr.course = :course, sr.`group` = :group ".
										  "WHERE sr.schedule_id = :schedule_id AND sr.slot_number = :slot_number AND " . 
											   "( ( sr.presenter_id = :presenter_id) OR adm.id = :presenter_id )");
		
		return $statement->execute($sr->jsonSerialize());
	}
	
	public static function DeleteSchedule(int $id, ?PDO $connection = null): bool {
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$statement = $connection->prepare("DELETE FROM `schedule_records` WHERE schedule_id = :id;" .
										  "DELETE FROM `schedules` WHERE id = :id");
		
		return $statement->execute(['id' => $id]);
	}

	public static function DeleteScheduleRecord(int $schedule_id, int $slot_number, int $requested_from_userid, ?PDO $connection = null): bool {
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$statement = $connection->prepare("DELETE FROM `schedule_records` WHERE schedule_id = :schedule_id 
												AND slot_number = :slot_number AND " .
												"((presenter_id = :requested_from_userid) OR :requested_from_userid IN ( SELECT id FROM `users` WHERE type = 'ADMIN'))");
		
		return $statement->execute(['schedule_id' => $schedule_id, 'slot_number' => $slot_number, 'requested_from_userid' => $requested_from_userid]);
	}

	public static function DeleteGoingRecord(string $title, ?PDO $connection = null): bool {
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$statement = $connection->prepare("DELETE FROM `going` WHERE title = :title");
		
		return $statement->execute(['title' => $title]);
	}
}

?>