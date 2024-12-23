#include<stdio.h>

#define MY_X 5
#define MY_Y 13
#define MESSAGE "This is our adder program.\n"


int calculator(int x, int y) {
	return x + y;
}

int main(int argc, char *argv[]) {
	printf(MESSAGE);
	
	int x_value = MY_X;
	int y_value = MY_Y;
	int result = calculator(x_value, y_value);
	
	printf("%d + %d = %d\n", x_value, y_value, result);

	return 0;
}



