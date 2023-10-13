<?php

class ScheduleTable implements JsonSerializable {
	private $title;
	private $date;
	private $schedule_start;
	private $schedule_end;
	private $schedule_step;
	private $created_by;

	public static function createFromJSON(array $scheduleInfo): ScheduleTable {
		return new ScheduleTable(
							$scheduleInfo['title'],
							$scheduleInfo['date'],
							$scheduleInfo['schedule_start'],
							$scheduleInfo['schedule_end'],
							$scheduleInfo['schedule_step'],
							$scheduleInfo['created_by']
		);
	}
	
	public function __construct(string $title, 
								string $date, 
								string $schedule_start, 
								string $schedule_end, 
								int $schedule_step, 
								int $created_by) {
		$this->title = $title;
		$this->date = new DateTime($date);
		$this->schedule_start = new DateTime($schedule_start);
		$this->schedule_end = new DateTime($schedule_end);
		$this->schedule_step = $schedule_step;
		$this->created_by = $created_by;
	}
	
	public function getTitle(): string {
		return $this->title;
	}
	
	public function getStartTime(): DateTime {
		return $this->schedule_start;
	}
	
	public function getEndTime(): DateTime {
		return $this->schedule_end;
	}
	
	public function getStep(): DateTime {
		return $this->schedule_step;
	}
	
	public function jsonSerialize(): array {
		return [
			"title" => $this->title,
			"date" => $this->date->format("Y-m-d"),
			"schedule_start" => $this->schedule_start->format("H:i"),
			"schedule_end" => $this->schedule_end->format("H:i"),
			"schedule_step" => $this->schedule_step,
			"created_by" => $this->created_by
		];
	}
}

?>
