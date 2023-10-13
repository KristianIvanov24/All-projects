function checkUsername() {
    var username = document.getElementById("username").value;
    var isValid = false;
    
    if(username.length == 0)
        document.getElementById("error-username").textContent = "* полето е задължително";
    else if(username.length>15)
        document.getElementById("error-username").textContent = "* невалидно потребителско име";
    else
        document.getElementById("error-username").textContent="";
        isValid = true;
    
    return isValid;
}

function checkPassword() {
    const password = document.getElementById("password").value;
    const regex = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{6,15}$)");

    let isValid = regex.test(password);

    if (password === "")
        document.getElementById("error-password").textContent = "* полето е задължително.";
    else if (!isValid)
        document.getElementById("error-password").textContent = "* невалидна парола";
    else
        document.getElementById("error-password").textContent='';

    return isValid;
}

function isValidLogin() {
    var userData = {
        username: document.getElementById('username').value,
        password: document.getElementById('password').value
    };

    fetch("./php/Session.php", {
        method: 'POST',
        body: JSON.stringify(userData)
    }).then(response => response.json())
        .then(r => {
            if (r['success']) {
                document.getElementById("errorForm").textContent='';
                window.location.href = "./home.html";
            }
            else
                document.getElementById("errorForm").textContent = 'Невалидно потребителско име или парола';
    });
}

function checkAll(event) {
    event.preventDefault();

    let isUsernameValid=checkUsername();
    let isPasswordValid=checkPassword();

    let isFormValid = isUsernameValid && isPasswordValid;

    if(isFormValid)
        isValidLogin();
}

document.getElementById('login-btn').addEventListener('click', checkAll);
