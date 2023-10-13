<?php

require_once('UserQueries.php');

try {
	switch ($_SERVER['REQUEST_METHOD']) {
		case 'GET': {
			RequestHandler::requireUserPermissions();
			if($_GET['by_what'] != 'id' && $_GET['by_what'] != 'username' && $_GET['by_what'] != 'faculty_number' && $_GET['by_what'] != 'email' && $_GET['by_what'] != 'username' && $_GET['by_what'] != 'current' || 
			   $_GET['what'] != 'id' && $_GET['what'] != 'username' && $_GET['what'] != 'faculty_number' && $_GET['what'] != 'email' && $_GET['what'] != 'type')
				throw new LogicException("bad request method");
			
			if($_GET['by_what'] == 'current')
				$userInfo = UserQueries::getUserBy('id', $_SESSION['id']);
			else
				$userInfo = UserQueries::getUserBy($_GET['by_what'], $_GET['value']);
			
			echo json_encode(['success' => true, 'value' => $userInfo[$_GET['what']]], JSON_UNESCAPED_UNICODE);
			break;
		}

		case 'POST': {
			$userInfo = json_decode(file_get_contents("php://input"), true);
			$userInfo['id'] = 0;
			$userInfo['type'] = "REGULAR"; 
			$registrationSuccessfull = UserQueries::RegisterUser(User::createFromJSON($userInfo));
			if($registrationSuccessfull)
				echo json_encode(['success' => true]);
			else
				echo json_encode(['success' => false, 'msg' => "registration unsuccessful"]);
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
