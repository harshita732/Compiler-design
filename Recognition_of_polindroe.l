%{
#include <stdio.h>
#include <string.h>

int isPalindrome(char *str);
%}

%%
[a-zA-Z]+ {
    if (isPalindrome(yytext)) {
        printf("%s is a palindrome\n", yytext);
    } else {
        printf("%s is not a palindrome\n", yytext);
    }
}
[^a-zA-Z]+ ; // Ignore non-alphabetic characters
%%

int isPalindrome(char *str) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        if (str[i] != str[len - i - 1]) {
            return 0; // Not a palindrome
        }
    }
    return 1; // Is a palindrome
}

int main() {
    printf("Enter words:\n");
    yylex();
    return 0;
}
