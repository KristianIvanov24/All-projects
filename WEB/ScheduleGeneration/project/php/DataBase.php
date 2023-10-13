<?php

class DB {
	private $host = "localhost";
	private $port = "3306";
	private $dbName = "project_db";
	private $username = "root";
	private $password = "";

	public function __construct(string $host, int $port, string $dbName, string $username, string $password) {
		$this->host = $host;
		$this->port = $port;
		$this->dbName = $dbName;
		$this->username = $username;
		$this->password = $password;
	}

	public function getConnection(): PDO {
		return new PDO("mysql:host={$this->host};port={$this->port};dbname={$this->dbName}", $this->username, $this->password,
					   [
						   PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8",
						   PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
					   ]);
	}
}

?>
