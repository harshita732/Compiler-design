%{
#include <stdio.h>
#include <math.h>
#include <string.h>

int binaryToDecimal(const char *binary);
%}

%%
[01]+    { 
            int decimal = binaryToDecimal(yytext); 
            printf("Binary: %s -> Decimal: %d\n", yytext, decimal); 
          }
[^01]+   ; // Ignore non-binary characters
%%

int binaryToDecimal(const char *binary) {
    int decimal = 0;
    int length = strlen(binary);
    for (int i = 0; i < length; i++) {
        if (binary[length - i - 1] == '1') {
            decimal += pow(2, i);
        }
    }
    return decimal;
}

int main() {
    printf("Enter binary numbers (non-binary characters will be ignored):\n");
    yylex();
    return 0;
}
