/*
 * Executable    : uppercaser2
 * Version       : 1.0
 * Created date  : 14/08/2026
 * Last update   : 14/08/2026
 * Author        : OPQAM
 * Description   : This is the remake of uppercaser (ASM version) into a C program. The idea is to act in the same way (from a user's perspective).
*/

#include<stdio.h>


int converter(int character);

int main(int argc, char *argv[])
{
    int x;

    while ((x = getchar()) != EOF)
    {
        printf("%c",converter(x));
    }
    
    return 0;
}

int converter(int character)
{
    if (character >= 0x61 && character <= 0x7A)
    {
        character -= 0x20;
    }
    return character;
}
