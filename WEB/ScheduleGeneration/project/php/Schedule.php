<?php

class Schedule implements JsonSerializable {
	private $schedule_id;
	private $slot_number;
	private $presenter_id;
	private $presentation_title;
	private $specialty;
	private $course;
	private $group;

	public static function createFromJSON(array $info): Schedule {
		return new Schedule( $info['schedule_id'],
							 $info['slot_number'],
                             $info['presenter_id'],
							 $info['presentation_title'],
							 $info['specialty'],
							 $info['course'],
							 $info['group']
						    );
	}

	public function __construct(int $schedule_id, 
								int $slot_number,
                                int $presenter_id,
								string $presentation_title, 
								string $specialty, 
								int $course, 
								int $group) {
		$this->schedule_id = $schedule_id;
		$this->slot_number = $slot_number;
        $this->presenter_id = $presenter_id;
		$this->presentation_title = $presentation_title;
		$this->specialty = $specialty;
		$this->course = $course;
		$this->group = $group;
	}

	public function jsonSerialize(): array {
		return [
			"schedule_id" => $this->schedule_id,
			"slot_number" => $this->slot_number,
            "presenter_id" => $this->presenter_id,
			"presentation_title" => $this->presentation_title,
			"specialty" => $this->specialty,
			"course" => $this->course,
			"group" => $this->group
		];
	}
}

?>