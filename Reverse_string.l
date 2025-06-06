%{
#include <stdio.h>
#include <string.h>
void reverse(char *str);
%}

%%
.+  { 
        reverse(yytext); 
        printf("%s\n", yytext); 
    }
%%

void reverse(char *str) {
    int len = strlen(str);
    int i;
    for (i = 0; i < len / 2; i++) {
        char temp = str[i];
        str[i] = str[len - i - 1];
        str[len - i - 1] = temp;
    }
}

int main() {
    yylex();
    return 0;
}
