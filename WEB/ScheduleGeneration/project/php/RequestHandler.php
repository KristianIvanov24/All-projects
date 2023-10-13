<?php

session_start();
require_once('DataBase.php');

class RequestHandler {
	public static function ConnectToDB(): PDO {
		$config = parse_ini_file('../config/project.ini', true);
		return (new DB($config['db']['host'], $config['db']['port'], $config['db']['name'], $config['db']['username'], $config['db']['password']))->getConnection();
	}

	public static function requireAdminPermissions() {
		if(!isset($_SESSION['logged']) || !$_SESSION['logged'] || !$_SESSION['is_admin'])
			throw new LogicException("admin permissions required");
	}

	public static function requireUserPermissions() {
		if(!isset($_SESSION['logged']) || !$_SESSION['logged'])
			throw new LogicException("user permissions required");
	}
}

?>
