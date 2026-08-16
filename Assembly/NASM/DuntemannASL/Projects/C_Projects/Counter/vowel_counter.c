/* Executable    : vowel_counter
 * Version       : 1.0
 * Created date  : 16/08/2026
 * Last update   : 16/08/2026
 * Author        : OPQAM
 * Description   : Just counting the number of vowels inputed by the user and returning that value
 * Build using the following:
 * gcc program.c -o program */

#include<stdio.h>


int main(int argc, char *argv[])
{
    int user_char;
    int counter = 0;
    char vowels[] = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'};

    while ((user_char = getchar()) != '\n')
    {
        for (int i = 0; i < 10; i++)
        {
            if (user_char == vowels[i])
        {
            counter++;
        }
        }
    }
    
    printf("%d\n", counter);

    return 0;
}
