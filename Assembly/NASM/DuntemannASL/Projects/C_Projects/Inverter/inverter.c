/* Executable    : inverter
 * Version       : 1.0
 * Created date  : 16/08/2026
 * Last update   : 16/08/2026
 * Author        : OPQAM
 * Description   : Taking the uppercaser (C version) and just simply switching it into a switcher. Upper becomes lower and vice-versa
 *
 * Build using the following:
 * gcc program.c -o program */

#include<stdio.h>


int inverter(int character);

int main(int argc, char *argv[])
{
    int x;

    while ((x = getchar()) != EOF)
    {
        printf("%c",inverter(x));
    }
    
    return 0;
}

int inverter(int character)
{
    if (character >= 0x61 && character <= 0x7A)
    {
        character -= 0x20;
    } else if (character >= 0x41 && character <= 0x5A)
    {
        character += 0x20;
    }

    return character;
}
