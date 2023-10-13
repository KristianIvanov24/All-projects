<?php

require_once('User.php');
require_once('RequestHandler.php');

class UserQueries
{
	public static function RegisterUser(User $user, ?PDO $connection = null): bool
	{
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$statement = $connection->prepare("INSERT INTO `users` (id, faculty_number, username, email, password, type) 
										   VALUES (:id, :faculty_number, :username, :email, :password, :type)");
		$userData = $user->jsonSerialize();
		$hashedPassword = password_hash($userData['password'], PASSWORD_DEFAULT);
		return $statement->execute([
			'id' => $userData['id'],
			'faculty_number' => $userData['faculty_number'],
			'username' => $userData['username'],
			'email' => $userData['email'],
			'password' => $hashedPassword,
			'type' => $userData['type']
		]);
	}
	public static function Login(array $loginData, ?PDO $connection = null): ?array
	{
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$statement = $connection->prepare("SELECT * FROM `users` WHERE username = :username");
		$statement->execute(['username' => $loginData['username']]);
		$result = $statement->fetch();
		if($result && password_verify($loginData['password'], $result['password']))
			return $result;
		return null;
	}
	public static function getUserBy(string $byWhat, string $val, ?PDO $connection = null): ?array
	{
		$connection = $connection ?? RequestHandler::ConnectToDB();
		$statement = $connection->prepare("SELECT * FROM `users` WHERE {$byWhat} = :{$byWhat}");
		$statement->execute([$byWhat => $val]);
		if($result = $statement->fetch()){
			return $result;
		}
		return null;
	}
}

?>
