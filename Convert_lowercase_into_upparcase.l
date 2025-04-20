%{
#include <stdio.h>
%}

%%
[a-z]+    { 
            int i;
            for(i = 0; yytext[i] != '\0'; i++) {
                yytext[i] = yytext[i] - 'a' + 'A';
            }
            printf("%s", yytext);
           }
.|\n       { printf("%s", yytext); }
%%

int main() {
    yylex();
    return 0;
}
