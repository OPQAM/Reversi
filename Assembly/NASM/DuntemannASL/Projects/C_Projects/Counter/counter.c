/* Executable    : counter
 * Version       : 1.0
 * Created date  : 16/08/2026
 * Last update   : 16/08/2026
 * Author        : OPQAM
 * Description   : Just counting the number of characters inputed by the user and returning that value
 * Build using the following:
 * gcc program.c -o program */

#include<stdio.h>


int main(int argc, char *argv[])
{
    int user_char;
    int counter = 0;

    while ((user_char = getchar()) != '\n')
    {
        if (user_char != ' ')
        {
            counter += 1;
        }
    }
    
    printf("%d\n", counter);

    return 0;
}
