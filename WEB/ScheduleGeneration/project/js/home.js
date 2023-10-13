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
    document.getElementById('homepage-main').appendChild(el);
}

function addSuccessLabel(content) {
    var el = document.createElement('label');
    el.id = 'success';
    el.innerHTML = content;
    document.getElementById('homepage-main').appendChild(el);
}

function getData() {
    fetch("./php/ScheduleRequestHandler.php", {
        method: 'GET'
    }).then(response => response.json())
        .then(async (r) => {
            if (r['success'] != null && !r['success'])
                addErrorLabel('error', `${r['msg']}`);
            else {
				var is_adm = await is_admin();
                r.forEach(element => {
                    serializeData(element);
                });
            }
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

async function getCurrentUser(what) {
	var res = null;
	await fetch("./php/UserController.php?by_what=current&what=" + what, {
		method: 'GET'
	}).then(response => response.json())
     	.then(r => {
			if(r['success']) 
            res = r['value'];
	});
	return res;
}

async function showAdminFeatures() {
	currentUserType = await getCurrentUser('type');
	if(currentUserType != 'ADMIN'){
		document.getElementById('create').style = "display: none";
	}
}

async function is_admin() {
    var currentUserType = await getCurrentUser('type');
    if(currentUserType == 'ADMIN')
        return true;
    return false;                
}

function deleteData(schedule_id) {
	var schedule_data = {id: schedule_id};
    fetch("./php/ScheduleRequestHandler.php", {
        method: 'DELETE',
        body: JSON.stringify(schedule_data)
    }).then(response => response.json())
        .then(async (r) => {
            if (!r['success'])
                addErrorLabel('', `error: ${r['msg']}`);
            else{
                const project = document.querySelector("article[project-id='"+schedule_id+"']");
                project.parentNode.removeChild(project);
            }
        });
}

async function serializeData(projectData){
    const isAdmin = await is_admin();
    const projects = document.querySelector("#projects");

    const project = document.createElement("article");
    project.classList.add("project");
    project.setAttribute("project-id", projectData.id);
    
    const title = document.createElement("p");
    title.id = "project-title";
    title.textContent = projectData.title;
    
    const date = document.createElement("p");
    date.id = "project-date";
    date.textContent = "Дата: " + projectData.date;
    
    const author = document.createElement("p");
    author.classList.add("project-author");

    fetch("./php/UserController.php?by_what=id&what=username&value=" + projectData.created_by, {
        method: 'GET'
    }).then(response => response.json())
        .then(r => {
            if (r['success']){
                author.textContent = "Автор: " + r.value;
                project.appendChild(title);
                project.appendChild(date);
                project.appendChild(author);
                project.append(btn_going);
            
                if(isAdmin){
                    const btnWrapper = document.createElement("div");
                    btnWrapper.classList.add("project-btn-wrapper");
                    const btn = document.createElement("button");
                    btn.classList.add("project-delete-btn");
                    btn.addEventListener("click", function(event){
                        deleteData(projectData.id);
                    });

                    btn.innerHTML = '<i class="fa fa-trash-o" aria-hidden="true"></i>';
                    btnWrapper.append(btn);
                    project.append(btnWrapper);
                }

                const bnt_view = document.createElement("button");
                bnt_view.id = "view";
                bnt_view.textContent = "Преглед";

                bnt_view.onclick = function(){
                    window.location.href = "./schedule.html?schedule_id=" + projectData.id;
                };

                project.appendChild(bnt_view);
                projects.appendChild(project);
            }
    });

    const btn_going = document.createElement("button");
    btn_going.classList.add("going");
    btn_going.id = "going";
    btn_going.textContent = "Ще присъствам";

    btn_going.addEventListener('click', function(event){
        var recordData = {
            user_id: getCurrentUser('id'),
            schedule_id: projectData.id,
            presentation_title: projectData.title,
            date: projectData.date
        };
        
        fetch("./php/Going.php", {
            method: 'POST',
            body: JSON.stringify(recordData)
         }).then(response => response.json())
            .then(r => {
                if (!r['success'])
                    addErrorLabel('', `Неуспешно записване: ${r['msg']}`);
            });
    })
}

window.addEventListener('load', getData);
window.addEventListener('load', showAdminFeatures);