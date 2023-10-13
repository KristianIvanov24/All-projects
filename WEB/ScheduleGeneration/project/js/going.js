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
    fetch("./php/Going.php", {
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


async function is_admin() {
    var currentUserType = await getCurrentUser('type');
    if(currentUserType == 'ADMIN')
        return true;
    return false;                
}

function deleteData(title) {
	var schedule_data = {title: title};
    fetch("./php/Going.php", {
        method: 'DELETE',
        body: JSON.stringify(schedule_data)
    }).then(response => response.json())
        .then(async (r) => {
            if (!r['success'])
                addErrorLabel('', `error: ${r['msg']}`);
            else{
                const project = document.querySelector("article[project-id='"+title+"']");
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

    project.appendChild(title);
    project.appendChild(date);

    const btn_notgoing = document.createElement("button");
    btn_notgoing.classList.add("not_going");
    btn_notgoing.textContent = "Няма да присъствам";
    btn_notgoing.addEventListener("click", function(event) {
        deleteData(projectData.title);
        location.reload();
        event.preventDefault();

    });

    project.appendChild(btn_notgoing);
    projects.appendChild(project);
}

window.addEventListener('load', getData);
