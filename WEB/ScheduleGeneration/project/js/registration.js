function checkUsername() {
    var username = document.getElementById("username").value;
    var isValid = false;
    
    if(username.length == 0)
        document.getElementById("error-username").textContent = "* полето е задължително";
    else if(username.length > 15)
        document.getElementById("error-username").textContent = "* невалидно потребителско име";
    else {
        document.getElementById("error-username").textContent = "";
        isValid = true;
    }

    return isValid;
}

function checkFacNum() {
    var fn = document.getElementById("fn").value;
    const regex = new RegExp("^[0-9]{5}$");
    var isValid = regex.test(fn);
    
    if(fn.length == 0)
        document.getElementById("error-fn").textContent = "* полето е задължително";
    else if(isValid)
        document.getElementById("error-fn").textContent = "";
    else
        document.getElementById("error-fn").textContent = "* невалиден факултетен номер";
    
    return isValid;
}

function checkEmail() {
    var email = document.getElementById("email").value;
    const regex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    let isValid = regex.test(email);

    if(email === "")
        document.getElementById("error-email").textContent = "*полето е задължително";
    else if(isValid)
        document.getElementById("error-email").textContent = "";
    else
        document.getElementById("error-email").textContent = "*невалиден имейл";
    
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
        document.getElementById("error-password").textContent = '';

    return isValid;
}

function checkExists() {
    var userData = {
        faculty_number: document.getElementById('fn').value,
        username: document.getElementById('username').value,
        email: document.getElementById('email').value,
        password: document.getElementById('password').value
    };

    fetch("./php/UserController.php", {
        method: 'POST',
        body: JSON.stringify(userData)
    }).then(response => response.json())
        .then(r => {
            if (r['success']) {
                document.getElementById("errorForm").textContent = 'Успешна регистрация';
                location.href = "./login.html";
            }
            else 
                document.getElementById("errorForm").textContent = 'Потребителското име е заето';   
        });
}

function registration(event) {
    event.preventDefault();

    let isUsernameValid = checkUsername();
    let isFacNumValid = checkFacNum();
    let isEmailValid = checkEmail();
    let isPasswordValid = checkPassword();

    let isFormValid = isUsernameValid && isFacNumValid && isEmailValid && isPasswordValid;

    if(isFormValid)
        checkExists();
}

document.querySelector('#register-btn').addEventListener('click', registration);
