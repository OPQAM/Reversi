/* Executable    : alphabet_counter
 * Version       : 1.0
 * Created date  : 16/08/2026
 * Last update   : 16/08/2026
 * Author        : OPQAM
 * Description   : Just counting the number of alphabetic characters inputed by the user and returning that value
 * Build using the following:
 * gcc program.c -o program */

#include<stdio.h>


int main(int argc, char *argv[])
{
    int user_char;
    int counter = 0;

    while ((user_char = getchar()) != '\n')
    {
        if ((user_char >= 'A' && user_char <= 'Z') || (user_char >= 'a' && user_char <= 'z'))
        {
            counter += 1;
        }
    }
    
    printf("%d\n", counter);

    return 0;
}

