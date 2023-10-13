function RemoveCurrentLabels() {
    var errorLabels = document.querySelectorAll('.error');
    for (var i = 0; i < errorLabels.length; i++)
        errorLabels[i].remove();
    var successLabel = document.querySelector('#success');
    if (successLabel != null) successLabel.remove();
}

function addErrorLabel(id, content) {
    var el = document.createElement('label');
    el.id = id;
    el.classList.add('error');
    el.innerHTML = content;
    document.getElementById('schedule-form').appendChild(el);
}

function addSuccessLabel(content) {
    var el = document.createElement('label');
    el.id = 'success';
    el.innerHTML = content;
    document.getElementById('schedule-form').appendChild(el);
}

function createSchedule() {
    var scheduleData = {
        title: document.getElementById('title').value,
        date: document.getElementById('date').value,
        schedule_start: document.getElementById('schedule-start').value,
        schedule_end: document.getElementById('schedule-end').value,
        schedule_step: document.getElementById('schedule-step').value
    };
   
    fetch("./php/ScheduleRequestHandler.php", {
        method: 'POST',
        body: JSON.stringify(scheduleData)
		
    }).then(response => {
        console.log(response);
        return response.json();
    }).then(r => {
        if (r['success']) 
            addSuccessLabel(`График (ID: ${r['inserted_id']}) е създаден успешно`);
        else
            addErrorLabel('schedule-creation-failed', `Неуспешно създаване на график: ${r['msg']}`);
    });
        
    //window.location.href = "./addSchedule.html";   
}

function exit() {
    fetch("./php/Session.php", {
        method: 'DELETE'
    }).then(response => response.json())
        .then(async (r) => {
            window.location.href = "./login.html";
    });
}

function checkAll(event) {
    
//console.log("ssssssssssssss");
    createSchedule();
    // RemoveCurrentLabels();
	//event.preventDefault();
}
document.querySelector('#create-schedule-btn').addEventListener('click', checkAll);