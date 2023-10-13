<?php

require_once('UserQueries.php');

try {
	switch ($_SERVER['REQUEST_METHOD']) {
		case 'POST': {
			$user = UserQueries::Login(json_decode(file_get_contents("php://input"), true));
			if($user!=null) {
				$_SESSION['logged'] = true;
				$_SESSION['id'] = $user['id'];
				$_SESSION['is_admin'] = $user['type'] =='ADMIN';
				echo json_encode(['success' => true]);
			}

			else echo json_encode(['success' => false, 'msg' => 'wrong username or password']);
			
			break;
		}

		case 'DELETE': {
			echo json_encode(['success' => session_destroy()]);
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
