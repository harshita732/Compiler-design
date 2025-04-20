%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int evaluate(char *expression);
%}

%%
[0-9+\-*/()]+ {
    int result = evaluate(yytext);
    printf("Expression: %s = %d\n", yytext, result);
}
\n|\t|\r  ; // Ignore whitespace characters
.          ; // Ignore all other characters
%%

int evaluate(char *expression) {
    int result = 0;
    char command[100];

    // Generating a C-based calculation
    sprintf(command, "echo $((%s))", expression);

    // Opening a shell pipeline for evaluation
    FILE *pipe = popen(command, "r");
    if (pipe == NULL) {
        perror("popen failed");
        exit(1);
    }

    // Reading the result
    fscanf(pipe, "%d", &result);
    pclose(pipe);

    return result;
}

int main() {
    printf("Enter an arithmetic expression (e.g., 3+4*2):\n");
    yylex();
    return 0;
}
