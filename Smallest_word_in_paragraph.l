%{
#include <stdio.h>
#include <string.h>

char smallestWord[100]; // Array to store the smallest word
int smallestWordLength = 100; // Arbitrarily high value for comparison

void updateSmallest(char *word);
%}

%%
[a-zA-Z]+   { 
                updateSmallest(yytext); 
            }
[^a-zA-Z]+   ; // Ignore non-word characters
%%

void updateSmallest(char *word) {
    int length = strlen(word);
    if (length < smallestWordLength) {
        strcpy(smallestWord, word);
        smallestWordLength = length;
    }
}

int main() {
    printf("Enter a paragraph:\n");
    yylex();
    printf("The smallest word is: %s\n", smallestWord);
    return 0;
}
