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
        for (int i = 0; fileUsername[i] != '\0'; i++) {
            if (username[i] != fileUsername[i]) {
                usernameMatch = false;
                break;
            }
        }
        for (int i = 0; i < filePassword[i] != '\0'; i++) {
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

void countRows(char** solved_matrix, int** &rows){
    //int** rows = new int*[level*5];
    int count = 0;
    for(int i = 0; i < level*5; i++){
        for(int j = 0; j < level*5; j++){
            if(solved_matrix[i][j] == '#'){
                count++;
                rows[i][j] = 'O';
            }
            else if(solved_matrix[i][j] == 'O' && count != 0){
                rows[i][j] = count;
                count = 0;
            }
            else rows[i][j] = 'O';
        }
    }

    //return rows;
}

void countColumns(char** solved_matrix, int** &columns){
    //int** colums = new int*[level*5];
    int count = 0;
    for(int i = 0; i < level*5; i++){
        for(int j = 0; j < level*5; j++){
            if(solved_matrix[j][i] == '#'){
                count++;
                columns[j][i] = 'O';
            }
            else if(solved_matrix[i][j] == 'O' && count != 0){
                columns[j][i] = count;
                count = 0;
            }
            else columns[j][i] = 'O';
        }
    }

    //return colums;
}

void printMatrix(char** player_matrix, int size, int** rows, int** columns){
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
            if(columns[i][j] != 0)
                std::cout << columns[i][j];
        }
        std::cout << std::endl;
    }

    for (int i = 0; i < size; i++) {
        for(int j = 0; j < size; j++){
            if(rows[i][j] != 0)
                std::cout << rows[i][j];
        }
        for (int j = 0; j < size; j++) {
            std::cout <<player_matrix[i][j];
        }
        std::cout << std::endl;
    }
}

bool compare(char** player_matrix, char** solved_matrix){}

void fillChunk(char** &player_matrix, char* cmd){}

void save(char** matrix){}

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

    int size = level * 5;
    char** solved_matrix = new char*[size];
    char** player_matrix = new char*[size];
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            file >> solved_matrix[i][j];
            player_matrix[i][j] = 'O';
        }
    }
    file.close();

    int** rows = new int*[size];
    countRows(solved_matrix, rows);

    int** columns = new int*[size];
    countColumns(solved_matrix, columns);

    char cmd[3];
    while(!compare(player_matrix, solved_matrix)){
        printMatrix(player_matrix, size, rows, columns);
        std::cout << "Choose coordinates for chunk to be filled in the given format 'number1' 'number2'. If you wish to exit type 'e'." << std::endl;
        std::cin >> cmd;

        if(cmd == "e"){
            save(player_matrix);
            return;
        }

        else fillChunk(player_matrix, cmd);
    }

    std::cout << "Congratulations! You solved level " << level << std::endl;
    level++;
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
            std::cout << check << std::endl;
            std::cout << "Wrong credentials!" << std::endl;
            check = validateData();
            std::cout << check << std::endl;
        }
        std::cout << "Login successful!" << std::endl;
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

        std::cout << "If you wish to play another game, please select between level 1 and level " << level << "or type 'e' to exit." << std::endl;
        std::cin >> cmd;
        if (cmd == 'e')
            return;
        else if((cmd + '0') == level)
            playGame();
        else{
            level = cmd + '0';
            loadGame();
        }
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
