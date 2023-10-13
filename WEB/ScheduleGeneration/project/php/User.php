<?php

class User implements JsonSerializable {
	private $id;
	private $username;
	private $faculty_number;
	private $email;
	private $password;
	private $type;

	public static function createFromJSON(array $userInfo): User {
		return new User($userInfo['id'],
						$userInfo['faculty_number'],
						$userInfo['username'],
						$userInfo['email'],
						$userInfo['password'],
						$userInfo['type']
		);
	}

	public function __construct(int $id, 
								string $faculty_number, 
								string $username, 
								string $email, 
								string $password, 
								string $type) {
		$this->id = $id;
		$this->faculty_number = $faculty_number;
		$this->username = $username;
		$this->email = $email;
		$this->password = $password;
		$this->type = $type;
	}
	
	public function getId(): int {
		return $this->id;
	}
	
	public function getFacultyNumber(): string {
		return $this->faculty_number;
	}
	
	public function getUsername(): string {
		return $this->name;
	}

	public function getType(): string {
		return $this->type;
	}
	
	public function jsonSerialize(): array {
		return [
			"id" => $this->id,
			"faculty_number" => $this->faculty_number,
			"username" => $this->username,
			"email" => $this->email,
			"password" => $this->password,
			"type" => $this->type
		];
	}
}

?>