<?php

require_once('ScheduleQueries.php');

try {
	switch ($_SERVER['REQUEST_METHOD']) {
		case 'GET': {
            //tova trqbwa da se promeni
			RequestHandler::requireUserPermissions();
			$allRecords = ScheduleQueries::GetGoingRecords($_SESSION['id']);

			echo json_encode($allRecords, JSON_UNESCAPED_UNICODE);
			break;
		}

		case 'POST': {
			RequestHandler::requireUserPermissions();
			$recordInfo = json_decode(file_get_contents("php://input"), true);
			$recordInfo['user_id'] = $_SESSION['id'];
			//var_dump($recordInfo);
			$created = ScheduleQueries::AddGoingRecord(GoingSchedule::createFromJSON($recordInfo));
			echo json_encode(['success' => $created]);
			
			break;
		}
		
        case 'DELETE': {
            RequestHandler::requireUserPermissions();
        	$recordInfo = json_decode(file_get_contents("php://input"), true);
            $deleted = ScheduleQueries::DeleteGoingRecord($recordInfo['title']);
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