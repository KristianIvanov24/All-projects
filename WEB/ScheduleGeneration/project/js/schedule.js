function addErrorLabel(id, content) {
    var el = document.createElement('label');
    el.id = id;
    el.classList.add('error');
    el.innerHTML = content;
    document.getElementsByClassName('inputForm')[0].appendChild(el);
}
function RemoveCurrentLabels() {
    var errorLabels = document.querySelectorAll('.error');
    for (var i = 0; i < errorLabels.length; i++)
        errorLabels[i].remove();
    var successLabel = document.querySelector('#success');
    if (successLabel != null) successLabel.remove();
}
function addSuccessLabel(content) {
    var el = document.createElement('label');
    el.id = 'success';
    el.innerHTML = content;
    document.getElementById('schedule-table').appendChild(el);
}
function checkField(fieldId, regexStr, errorMsg) {
    var x = document.getElementById(fieldId);
    const regex = new RegExp(regexStr);
    if (!regex.test(x.value)) {
        if (document.getElementById('error-' + fieldId) == null)
            addErrorLabel('error-' + fieldId, errorMsg);
        return false;
    }
    return true;
}
function checkAll() {
	RemoveCurrentLabels();
    
	var allCorrect = true;
    if (!checkField('titleInput', '.+', 'Моля, въведете заглавие на презентацията.'))
        allCorrect = false;
    if (!checkField('specialtyInput', '.+', 'Моля, въведете специалност.'))
        allCorrect = false;
    if (!checkField('courseInput', '.+', 'Моля, въведете курс.'))
        allCorrect = false;
    if (!checkField('groupInput', '.+', 'Моля, въведете група.'))
        allCorrect = false;
    
	return allCorrect;
}
function addNewRecord(slotNumber) {
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);

	var recordData = {
        schedule_id: urlParams.get('schedule_id'),
        slot_number: slotNumber,
        presentation_title: document.getElementById('titleInput').value,
        specialty: document.getElementById('specialtyInput').value,
        course: document.getElementById('courseInput').value,
        group: document.getElementById('groupInput').value
    };

	fetch("./php/ScheduleRecordRequestHandler.php", {
        method: 'POST',
        //headers: 'Content-Type: application/json;',
        body: JSON.stringify(recordData)
     }).then(response => response.json())
        .then(r => {
            if (!r['success'])
                addErrorLabel(`Неуспешно записване: ${r['msg']}`);
			else
                addSuccessLabel('Записът беше успешен.');
        });
}

function changeRecord(slotNumber) {
    const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);
	
	var recordData = {
        schedule_id: urlParams.get('schedule_id'),
        slot_number: slotNumber,
        presentation_title: document.getElementById('titleInput').value,
        specialty: document.getElementById('specialtyInput').value,
        course: document.getElementById('courseInput').value,
        group: document.getElementById('groupInput').value
    };
    
	fetch("./php/ScheduleRecordRequestHandler.php", {
        method: 'PUT',
        body: JSON.stringify(recordData)
    }).then(response => response.json())
        .then(r => {
            if (!r['success'])
                addErrorLabel(`change-${slotNumber}`, `Неуспешна промяна: ${r.msg}`);
			else
                addSuccessLabel(`change-${slotNumber}`, 'Промяната беше успешна.');
        });
}

function deleteRecord(slotNumber) {
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);
    
	var recordData = {
        schedule_id: urlParams.get('schedule_id'),
        slot_number: slotNumber
    };
    
	fetch("./php/ScheduleRecordRequestHandler.php", {
        method: 'DELETE',
        body: JSON.stringify(recordData)
    }).then(response => response.json())
        .then(r => {
            if (!r['success'])
			    addErrorLabel('', `Изтриването не е успешно: ${r['msg']}`);
			else 
                addSuccessLabel('Изтриването беше успешно.');
        });
}

function exit() {
    fetch("./php/Session.php", {
        method: 'DELETE'
    }).then(response => response.json())
        .then(async (r) => {
            window.location.href = "./login.html";
    }); 
}
	
function RemoveCurrentForms() {
	var inputForms = Array.from(document.querySelectorAll('.inputForm'));
    inputForms.forEach(function(form) {
        form.remove();
    });
}
	
async function getCurrentUser(what) {
	return new Promise((resolve, reject) => {
        fetch("./php/UserController.php?by_what=current&what=" + what, {
            method: 'GET'
        })
            .then(response => response.json())
            .then(r => {
                if (r['success'])
                    resolve(r['value']);
                else
                    resolve(null);
            })
            .catch(error => {
                reject(error);
            });
    });
}

async function showAdminFeatures() {
    var currentUserType = await getCurrentUser('type');
    if(currentUserType == 'ADMIN')
		return true;
	return false;		
}

function insertAfter(referenceNode, newNode) {
   referenceNode.parentNode.insertBefore(newNode, referenceNode.nextElementSibling);
}

async function newInputForm(event){
    //console.log('111111111111111111');
	//RemoveCurrentForms();
  var newForm = document.createElement("form");

  newForm.id = "form" + this.id;
  newForm.className += "inputForm";
  newForm.style.display = "none";
  insertAfter(document.getElementById("schedule-table"), newForm);
  var tableRecords = document.getElementById(this.id);

  var newTitle = document.createElement("input");
  newTitle.id = "titleInput";
  newTitle.classList.add("add-records");
  newTitle.placeholder = "Тема";
  newTitle.type = "text";
  newTitle.value = tableRecords.getElementsByTagName("td")[3].innerHTML;
  document.getElementById(newForm.id).appendChild(newTitle);

  var newSpecialty = document.createElement("input");
  newSpecialty.id = "specialtyInput";
  newSpecialty.classList.add("add-records");
  newSpecialty.placeholder = "Специалност";
  newSpecialty.value = tableRecords.getElementsByTagName("td")[4].innerHTML;
  newSpecialty.type = "text";
  document.getElementById(newForm.id).appendChild(newSpecialty);

  var newCourse = document.createElement("input");
  newCourse.id = "courseInput";
  newCourse.classList.add("add-records");
  newCourse.placeholder = "Курс";
  newCourse.value = tableRecords.getElementsByTagName("td")[5].innerHTML;
  newCourse.type = "text";
  document.getElementById(newForm.id).appendChild(newCourse);

  var newGroup = document.createElement("input");
  newGroup.id = "groupInput";
  newGroup.classList.add("add-records");
  newGroup.placeholder = "Група";
  newGroup.value = tableRecords.getElementsByTagName("td")[6].innerHTML;
  newGroup.type = "text";
  document.getElementById(newForm.id).appendChild(newGroup);

  var is_admin = await showAdminFeatures();

  var submitBtn = document.createElement("button");
  submitBtn.id = "save-btn" + this.id;
  submitBtn.innerHTML = "Запази";
  submitBtn.onclick = function (event) {
    if (checkAll()) {
      if (tableRecords.getElementsByTagName("td")[2].innerHTML == "") {
          addNewRecord(this.id.substr("save-btn".length));
          //console.log('111111133wfer');
      }
      else
          changeRecord(this.id.substr("save-btn".length));
      location.reload();
    }
    event.preventDefault();
  };
  document.getElementById(newForm.id).appendChild(submitBtn);

  var deleteBtn = document.createElement("button");
  deleteBtn.id = "del-btn" + this.id;
  deleteBtn.innerHTML = "Изтрий запис";

  deleteBtn.onclick = function (event) {
    deleteRecord(this.id.substr("del-btn".length));
    location.reload();
    event.preventDefault();
  };
  document.getElementById(newForm.id).appendChild(deleteBtn);

  var presenter_username = tableRecords.getElementsByTagName("td")[2].innerHTML;
  if (presenter_username == "" || is_admin) {
    newForm.style.display = "";
  } else {
    var presenter_id;
    await fetch("./php/UserController.php?by_what=username&what=id&value=" + presenter_username,
      {
        method: "GET",
      }
    )
      .then((response) => response.json())
	  .then((r) => {
		  if (r.success) {
          presenter_id = r.data.id;
        }
      });

    if (presenter_id == is_admin) {
      newForm.style.display = "";
    }
  }
}

async function getRecord() {
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);
	var schedule_id = urlParams.get('schedule_id');
	
	var start_time, end_time, step;
	await fetch("./php/ScheduleRequestHandler.php?id=" + schedule_id, {
        method: 'GET'
    }).then(response => response.json())
        .then(r => {
            if (r['success'] != null && !r['success'])
                addErrorLabel('error', `${r['msg']}`);
            else {
                start_time = r['schedule_start'];
				end_time = r['schedule_end'];
				step = r['schedule_step'];
				document.getElementById("head-title").textContent=r['title'];
            }
        });
	
    await fetch("./php/ScheduleRecordRequestHandler.php?schedule_id=" + schedule_id, {
        method: 'GET'
    }).then(response => response.json())
        .then(async (r) => {
            if (r['success'] != null && !r['success'])
                addErrorLabel('error', `${r['msg']}`);
            else {
				let cnt = i = 0;
                for (; i < Object.keys(r).length; i++) {

					for(; cnt < r[i]['slot_number']; cnt++){
						var tbodyRef = document.getElementById('schedule-table').getElementsByTagName('tbody')[0];
						var newRow = tbodyRef.insertRow();
						newRow.id = cnt;
						newRow.addEventListener("click",newInputForm);
						insertCell(newRow, cnt + 1);
						var startTime = convertStartTime(start_time, cnt, step);
						var endTime = convertEndTime(startTime, step);
						insertCell(newRow, startTime.substr(0, 5) + " - " + endTime.substr(0, 5));
						insertCell(newRow, "");
						insertCell(newRow, "");
						insertCell(newRow, "");
						insertCell(newRow, "");
                        insertCell(newRow, "");
					}
					
					var tbodyRef = document.getElementById('schedule-table').getElementsByTagName('tbody')[0];
                    var newRow = tbodyRef.insertRow();
					newRow.id = cnt;
                   // console.log('111111111111111111');
					newRow.addEventListener('click' ,newInputForm);
                   // console.log('111111111111111111');
					insertCell(newRow, cnt + 1);
					var newStartTime = convertStartTime(start_time, r[i]['slot_number'], step);
					var newEndTime = convertEndTime(newStartTime, step);
                    insertCell(newRow, newStartTime.substr(0, 5) + " - " + newEndTime.substr(0, 5));
					var presenter = r[i]['presenter_id'];
					var presenter_fn = "";
					var is_admin = await showAdminFeatures();
					if(is_admin){
						await fetch("./php/UserController.php?by_what=id&what=faculty_number&value=" + presenter, {
							method: 'GET'
						}).then(response => response.json())
							.then(r => {
								if (r['success'])
									presenter_fn = r['value'];
							});
					}
					await fetch("./php/UserController.php?by_what=id&what=username&value=" + presenter, {
                        method: 'GET'
                    }).then(response => response.json())
                        .then(r => {
                            console.log(r);
                            if (r['success'])
                                insertCell(newRow, r['value'] + (presenter_fn==""? "": " (" + presenter_fn + ")"));
                            else
                                insertCell(newRow, `Username not found; ID: ${presenter}`);
                        });
					insertCell(newRow, r[i]['presentation_title']);
                    insertCell(newRow, r[i]['specialty']);
                    insertCell(newRow, r[i]['course']);
                    insertCell(newRow, r[i]['group']);

					cnt++;
                }

				var maxTime = maxSlotNumber(start_time, end_time, step);
				for(; cnt < maxTime; cnt++){
					var tbodyRef = document.getElementById('schedule-table').getElementsByTagName('tbody')[0];
					var newRow = tbodyRef.insertRow();
					newRow.id = cnt;
					newRow.addEventListener("click",newInputForm);
					insertCell(newRow, cnt + 1);
					var startTime = convertStartTime(start_time, cnt, step);
					var endTime = convertEndTime(startTime, step);
					insertCell(newRow, startTime.substr(0, 5) + " - " + endTime.substr(0, 5));
					insertCell(newRow, "");
					insertCell(newRow, "");
					insertCell(newRow, "");
					insertCell(newRow, "");
                    insertCell(newRow, "");
				}
			
            }
        });
}

function convertToTime(timeString) {
  var timeParts = timeString.split(":");
  var hours = parseInt(timeParts[0]);
  var minutes = parseInt(timeParts[1]);
  var time = new Date();
  time.setHours(hours);
  time.setMinutes(minutes);
  time.setSeconds(0);
  return time;
}

function maxSlotNumber(schedule_start, schedule_end, schedule_step){
	var start_time = convertToTime(schedule_start);
	var end_time = convertToTime(schedule_end);
	var slot_duration = parseInt(schedule_step);
	var diff = Math.abs(end_time - start_time);
	var minutes = Math.floor(diff / 60000);
	var slots = Math.floor(minutes / slot_duration);
	return slots;
}

function convertEndTime(schedule_start, schedule_step){
	var start_time = convertToTime(schedule_start);
	var slot_duration = parseInt(schedule_step);
	var end_time = new Date(start_time.getTime() + slot_duration * 60000);
	var end_hours = end_time.getHours().toString().padStart(2, "0");
	var end_minutes = end_time.getMinutes().toString().padStart(2, "0");
	var end_time_string = end_hours + ":" + end_minutes;
	return end_time_string;
}

function convertStartTime(schedule_start, slot_number, schedule_step){
	var start_time = convertToTime(schedule_start);
	var slot_duration = parseInt(schedule_step);
	var start_time_ms = start_time.getTime() + slot_number * slot_duration * 60000;
	var start_time_new = new Date(start_time_ms);
	var start_hours = start_time_new.getHours().toString().padStart(2, "0");
	var start_minutes = start_time_new.getMinutes().toString().padStart(2, "0");
	var start_time_string = start_hours + ":" + start_minutes;
	return start_time_string;
}
function insertCell(row, value) {
	var newCell = row.insertCell();
	newCell.innerHTML = value;
	newCell.classList.add("record-info");
	// var newCell = row.insertCell();
  // var newText = document.createTextNode(content);
  // newCell.appendChild(newText);
}






window.addEventListener('load', getRecord);