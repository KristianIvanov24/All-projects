#include <iostream>
#include <fstream>
#include <cstdlib>
#include <ctime>

char username[10];
char password[10];
char level[3];

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

    level[0] = 1;
    file << username << " " << password << " " << level << std::endl;
    file.close();

    return true;
}

void countRows(char** solved_matrix, int** &rows){
    int count = 0;
    int size = 5*(int(level[0]) - 48);
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
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
}

void countColumns(char** solved_matrix, int** &columns){
    //int** colums = new int*[level*5];
    int count = 0;
    int size = 5*(int(level[0]) - 48);
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
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

bool compare(char** player_matrix, char** solved_matrix){
    int size = 5*(int(level[0]) - 48);
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
            if(player_matrix[i][j] != solved_matrix[i][j])
                return false;
        }
    }

    return true;
}

void fillChunk(char** &player_matrix, char* cmd){
    int x = int(cmd[0]) - 48, y = int(cmd[2]) - 48;

    player_matrix[x][y] = '#';
}

void save(char** matrix){
    char filename[20] = "m_n_";
    filename[0] = level[0];
    filename[1] = level[1];

    int i = 4;
    for(int j = 0; username[j] != '\0'; i++, j++){
        filename[i] = username[j];
    }

    filename[i] = '.';
    filename[i+1] = 't';
    filename[i+2] = 'x';
    filename[i+3] = 't';
    
    std::ofstream file(filename);
    int size = 5*(int(level[0]) - 48);
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            file << matrix[i][j];
        }
        file << std::endl;
    }

    file.close();
}

void loadGame(){
    char filename[20];

    for(int i = 0; i < 3; i++){
        filename[i] = level[i];
    }

    filename[3] = '_';
    int i = 4;
    for(int j = 0; username[j] != '\0'; j++, i++){
        filename[i] = username[j];
    }

    filename[i] = '.';
    filename[i+1] = 't';
    filename[i+2] = 'x';
    filename[i+3] = 't';

    std::ifstream file(filename);
    if (!file.is_open()) {
        std::cout << "Error: Unable to open file." << std::endl;
        return;
    }

    int size = 5*(int(level[0]) - 48);
    
    char** player_matrix = new char*[size];
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            file >> player_matrix[i][j];
        }
    }
    file.close();

    std::ifstream file(level);
    if (!file.is_open()) {
        std::cout << "Error: Unable to open file." << std::endl;
        return;
    }
    char** solved_matrix = new char*[size];
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            file >> solved_matrix[i][j];
        }
    }
    file.close();

    int** rows = new int*[size];
    countRows(solved_matrix, rows);

    int** columns = new int*[size];
    countColumns(solved_matrix, columns);

    char cmd[3];
    do{
        printMatrix(player_matrix, size, rows, columns);
        std::cout << "Choose coordinates for chunk to be filled in the given format 'number1' 'number2'. If you wish to exit type 'e'. If you wish to check your nonogram type 'c'" << std::endl;
        std::cin >> cmd;

        if(cmd == "c")
            if(!compare(player_matrix, solved_matrix)){
                std::cout << "There are mistakes in the puzzle solution." << std::endl;
            }
            else{
                std::cout << "Congratulations! You've solved level " << level << std::endl;
                level[0] = (size/5 + 1) + '0' ;
                break;
            }
        else fillChunk(player_matrix, cmd);
    } while(cmd != "e");

    save(player_matrix);
}

void playGame() {
    int currLvl = int(level[0]) - 48; 
    if (currLvl != 1) {
        std::cout << "You can choose between level 1 and level " << level << std::endl;
        std::cin >> currLvl;
    }

    srand(time(NULL));
    int randomNumber = rand() % 2 + 1;

    char fileName[8] = "n_m.txt";
    fileName[0] = currLvl;
    fileName[2] = randomNumber + '0';

    std::ifstream file(fileName);
    if (!file.is_open()) {
        std::cout << "Error: Unable to open file." << std::endl;
        return;
    }

    int size = currLvl * 5;
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
    do{
        printMatrix(player_matrix, size, rows, columns);
        std::cout << "Choose coordinates for chunk to be filled in the given format 'number1' 'number2'. If you wish to exit type 'e'. If you wish to check your nonogram type 'c'" << std::endl;
        std::cin >> cmd;

        if(cmd == "c")
            if(!compare(player_matrix, solved_matrix)){
                std::cout << "There are mistakes in the puzzle solution." << std::endl;
            }
            else{
                std::cout << "Congratulations! You've solved level " << level << std::endl;
                level[0] = (size/5 + 1) + '0' ;
                break;
            }
        else fillChunk(player_matrix, cmd);
    } while(cmd != "e");

    save(player_matrix);
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
        else{
            level[0] = cmd + '0';
            playGame();
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
