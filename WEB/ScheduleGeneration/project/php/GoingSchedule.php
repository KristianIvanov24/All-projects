<?php

class GoingSchedule implements JsonSerializable {
	private $user_id;
	private $schedule_id;
	private $presentation_title;
	private $date;

	public static function createFromJSON(array $info): GoingSchedule {
		return new GoingSchedule($info['user_id'],
								 $info['schedule_id'],
								 $info['presentation_title'],
								 $info['date']
		);
	}

	public function __construct(int $user_id, 
								int $schedule_id, 
								string $presentation_title, 
								string $date) {
		$this->user_id = $user_id;
		$this->schedule_id = $schedule_id;
		$this->presentation_title = $presentation_title;
		$this->date = DateTime::createFromFormat("Y-m-d", $date);
	}

	public function jsonSerialize(): array {
		return [
			"user_id" => $this->user_id,
			"schedule_id" => $this->schedule_id,
			"presentation_title" => $this->presentation_title,
			"date" => $this->date->format("Y-m-d")
		];
	}
}

?>
