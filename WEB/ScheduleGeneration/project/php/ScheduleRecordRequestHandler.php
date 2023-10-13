<?php

require_once('ScheduleQueries.php');

try {
	switch ($_SERVER['REQUEST_METHOD']) {
		case 'GET': {
			RequestHandler::requireUserPermissions();
			$allRecords = ScheduleQueries::GetScheduleRecords(intval($_GET['schedule_id']));
			echo json_encode($allRecords, JSON_UNESCAPED_UNICODE);
			
			break;
		}
		
		case 'POST': {
			//echo json_encode($_SERVER['REQUEST_METHOD']);
			/*RequestHandler::requireUserPermissions();*/
			$recordInfo = json_decode(file_get_contents("php://input"), true);
			//var_dump($recordInfo);
			$recordInfo['presenter_id'] = 2; //$_SESSION['id'];
			$created = ScheduleQueries::AddScheduleRecord(Schedule::createFromJSON($recordInfo));
			//var_dump($created);
			echo json_encode(['success' => $created]);
			
			break;
		}

		case 'PUT': {
			RequestHandler::requireUserPermissions();
			$recordInfo = json_decode(file_get_contents("php://input"), true);
			$recordInfo['presenter_id'] = $_SESSION['id'];
			if(isset($recordInfo['grade']))
				RequestHandler::requireAdminPermissions();
			else
				$recordInfo['grade'] = null;
			
			$updated = ScheduleQueries::UpdateScheduleRecord(Schedule::createFromJSON($recordInfo));
			echo json_encode(['success' => $updated]);
			
			break;
		}

		case 'DELETE': {
			RequestHandler::requireUserPermissions();
			$recordInfo = json_decode(file_get_contents("php://input"), true);
			$deleted = ScheduleQueries::DeleteScheduleRecord($recordInfo['schedule_id'], $recordInfo['slot_number'], $_SESSION['id']);
			echo json_encode(['success' => $deleted]);
			
			break;
		}

		default:
			throw new LogicException("bad request method");
	}
}

catch(Exception $e) {
	echo json_encode(['success' => false, 'msg' => $e->getMessage()]);
}

?>
