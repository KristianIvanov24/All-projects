#include "Task.h"
#include <fstream>
#include <algorithm>

void SaveTasksToFile(const std::vector<Task>& tasks, const std::string& filename){
	std::ofstream ofs(filename);
	if (!ofs.is_open())
		throw "Unable to open the file!";

	ofs << tasks.size();

	for (const Task& task : tasks){
		std::string description = task.description;
		std::replace(description.begin(), description.end(), ' ', '_');

		ofs << '\n' << description << ' ' << task.done;
	}
}

std::vector<Task> LoadTasksFromFile(const std::string& filename){
	std::ifstream ifs(filename);
	if (!ifs.is_open())
		throw "Unable to open the file!";
	
	std::vector<Task> tasks;
	
	int n;
	ifs >> n;

	for (int i = 0; i < n; i++){
		std::string description;
		bool done;

		ifs >> description >> done;
		std::replace(description.begin(), description.end(), '_', ' ');
		tasks.push_back(Task{ description, done });
	}

	return tasks;
}