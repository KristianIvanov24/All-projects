<?php

require_once('ScheduleQueries.php');
require_once('ScheduleTable.php');

try {
	switch ($_SERVER['REQUEST_METHOD']) {
		case 'GET': {
			RequestHandler::requireUserPermissions();
			if(!isset($_GET['id'])) {
				$allSchedules = ScheduleQueries::GetAllSchedules();
				echo json_encode($allSchedules, JSON_UNESCAPED_UNICODE);	
			}
			
			else {
				$scheduleInfo = ScheduleQueries::GetScheduleById(intval($_GET['id']));
				if($scheduleInfo)
					echo json_encode($scheduleInfo, JSON_UNESCAPED_UNICODE);
				else 
                    echo json_encode(['success' => false, 'msg' => "Графикът не е намерен"]);
            }
			
			break;
		}

		case 'POST': {
			$scheduleInfo = json_decode(file_get_contents("php://input"), true);
			$scheduleInfo['created_by'] = 1;
			$result = ScheduleQueries::CreateSchedule(ScheduleTable::createFromJSON($scheduleInfo));
			if($result != null)
				echo json_encode(['success' => true, 'inserted_id' => $result]);
			else
				echo json_encode(['success' => false]);
			break;
		}

		case 'PUT': {
			RequestHandler::requireAdminPermissions();
			$scheduleInfo = json_decode(file_get_contents("php://input"), true);
			break;
		}

		case 'DELETE': {
			RequestHandler::requireAdminPermissions();
			$scheduleInfo = json_decode(file_get_contents("php://input"), true);
			$deleted = ScheduleQueries::DeleteSchedule($scheduleInfo['id']);
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
