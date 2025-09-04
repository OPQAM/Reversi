#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#define CURRENT_LEVEL "Level 01"
#define NEXT_LEVEL "./pass_level_02"

int main() {
    const char password[] = "Consider_Phlebas";
    const char next_level[] = NEXT_LEVEL;
    char user_guess[20];

    printf("The Password Games!\n");
    printf("\nWelcome to %s.\n", CURRENT_LEVEL);
    sleep(1);

    printf("\nPlease Enter the Password: ");
    scanf("%19s", user_guess); /* Length limit for added safety */

    if (strcmp(user_guess, password) == 0) {
        printf("Congratulations! You have found the correct password!\n");
    	printf("Loading next level...\n");
	sleep(2);

	if (system(next_level) == -1) {
		printf("Error: could not load next level.\n");
		return 1;
	}
    } else {
        printf("Wrong Password!\n", user_guess);
	return 2;
    }    
    return 0;
}

