#include <iostream>
#include <fstream>
#include <cstdlib>
#include <ctime>

char username[10];
char password[10];
int level = 1;

bool validateData(){
    std::ifstream file("users.txt");

    if (!file.is_open()) {
        std::cout << "Error: Unable to open file." << std::endl;
        return false;
    }

    std::cout << "Enter your username: ";
    std::cin >> username;
    std::cout << "Enter your password: ";
    std::cin >> password;

    char fileUsername[10], filePassword[10];
    while (file >> fileUsername >> filePassword >> level) {
        bool usernameMatch = true, passwordMatch = true;
        for (int i = 0; i < strlen(username); i++) {
            if (username[i] != fileUsername[i]) {
                usernameMatch = false;
                break;
            }
        }
        for (int i = 0; i < strlen(password); i++) {
            if (password[i] != filePassword[i]) {
                passwordMatch = false;
                break;
            }
        }
        if (usernameMatch && passwordMatch) {
            file.close();
            return true;
        }
    }

    file.close();
    return false;
}

bool userReg(){
    while (validateData()) {
        std::cout << "User credentials already exist!" << std::endl;
    }
    
    std::ofstream file("users.txt", std::ios::app);

    if (!file.is_open()) {
        std::cout << "Error: Unable to open file." << std::endl;
        return false;
    }

    level = 1;
    file << username << " " << password << " " << level << std::endl;
    file.close();

    return true;
}

void loadGame(){}

void playGame() {
    if (level != 1) {
        std::cout << "You can choose between level 1 and level " << level << std::endl;
        std::cin >> level;
    }

    srand(time(NULL));
    int randomNumber = rand() % 2 + 1;

    char fileName[8] = "n_m.txt";
    fileName[0] = level + '0';
    fileName[2] = randomNumber + '0';

    std::ifstream file(fileName);
    if (!file.is_open()) {
        std::cout << "Error: Unable to open file." << std::endl;
        return;
    }

    //std::cout << "U gud?" << std::endl;

    int size = level * 5;
    //std::cout << size << std::endl;
    char solved_matrix[size][size], player_matrix[size][size];
    
    //for (int i = 0; i < size; i++) {
    //    for (int j = 0; j < size; j++) {
    //        file >> solved_matrix[i][j];
    //        //player_matrix[i][j] = 'O';
    //    }
    //}
    //file.close();

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            player_matrix[i][j] = 'O';
        }
    }

    // print out the matrix
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            std::cout <<player_matrix[i][j];
        }
        std::cout << std::endl;
    }
}

void NonogramGame() {
    std::cout << "Hello! This is Nonogram Game." << std::endl;

    char cmd;
    std::cout << "Please type 'l' for login or 'r' for registration. And if u wish to exit type 'e'." << std::endl;
    std::cout << '>';
    std::cin >> cmd;

    while (cmd != 'l' && cmd != 'r' && cmd != 'e') {
        std::cout << "Incorrect command!" << std::endl;
        std::cout << "Please type 'l' for login or 'r' for registration." << std::endl;
        std::cout << '>';
        std::cin >> cmd;
    }

    if (cmd == 'l') {
        bool check = validateData();
        while (!check) {
            std::cout << "Wrong credentials!" << std::endl;
            check = validateData();
        }

        std::cout << "If you want to continue your last game at level " << level << " type 'c' or if you want new game type 'n'" << std::endl;
        std::cout << '>';
        std::cin >> cmd;

        while (cmd != 'c' && cmd != 'n') {
            std::cout << "Incorrect command!" << std::endl;
            std::cout << "If you want to continue your last game at level " << level << " type 'c' or if you want new game type 'n'" << std::endl;
            std::cout << '>';
            std::cin >> cmd;
        }

        if (cmd == 'c')
            loadGame();
        else if (cmd == 'n')
            playGame();
        else return;
    }

    else if (cmd == 'r') {
        bool check = userReg();

        while (!check) {
            std::cout << "Registration unsuccessful! Try again." << std::endl;
            check = userReg();
        }

        std::cout << "Registration successful!" << std::endl;
    }
        
    else return;
}

int main() {
    NonogramGame();
    return 0;
}
