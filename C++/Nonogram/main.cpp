#include <iostream>
#include <fstream>

const int BUFF_SIZE = 1024;
char user[10];
char password[10];
int level = 1;

int validateData(){}

void userLogin(){}

void userReg(){}

void loadGame(){
    char matrix[BUFF_SIZE][BUFF_SIZE]; 
}

void NonogramGame(){
    std::cout << "Hello! This is Nonogram Game." << std::endl;
    
    char cmd;
    std::cout << "Please type 'l' for login or 'r' for registration." << std::endl;
    std::cout << '>';
    std::cin >> cmd;
    
    while(cmd != 'l' || cmd != 'r'){
        std::cout << "Incorrect command!" << std::endl;
        std::cout << "Please type 'l' for login or 'r' for registration." << std::endl;
        std::cout << '>';
        std::cin >> cmd;
    }
    
    if(cmd == 'l'){
        userLogin();
        
        std::cout << "If you want to continue your last game at level " << level << " type 'c' or if you want new game type 'n'" << std::endl;
        std::cout << '>';
        std::cin >> cmd;
        
        while(cmd != 'c' || cmd != 'n'){
            std::cout << "Incorrect command!" << std::endl;
            std::cout << "If you want to continue your last game at level " << level << " type 'c' or if you want new game type 'n'" << std::endl;
            std::cout << '>';
            std::cin >> cmd;
        }
        
        if(cmd == 'c')
            loadGame();
        else newGame();
    }
        
    else userReg();
    
    
    
    
}

int main() {

    return 0;
}
