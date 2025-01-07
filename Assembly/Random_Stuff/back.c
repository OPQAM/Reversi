#include <stdio.h>

int main() {
    char key[] = "SuperCaliFragilisticExpiralidoso";
    char password[] = "ImaginePhlebas";
    char user_guess[20]; // How do I dynamically allocate this memory? Should I?

    printf("Please Introduce the Password: ");
    scanf("%s", user_guess);

    if (user_guess == password) {

        printf("Congratulations! The key is: %s.\nCome again.", key);
    } else {
        prinff("I am sorry, but %s is incorrect.", user_guess);
    }
    
    return 0;


}
