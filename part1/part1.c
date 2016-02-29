//Bill Ma, Elmer Santos
//EEC 181 lab3 part 1

#include <stdio.h>

int main()
{
volatile int * bus = (int *) 0xFF200018;
int user_input;
char unwantedChars[40];
unwantedChars[0] = 0;

while(1){
printf("enter a number: ");
scanf("%d", &user_input);

gets(unwantedChars);

*(bus) = user_input;

}

return 0;
}