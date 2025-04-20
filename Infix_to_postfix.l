%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#define MAX 100

char stack[MAX];
int top = -1;

void push(char c);
char pop();
int precedence(char c);
void infixToPostfix(const char *infix, char *postfix);
%}

%%
[a-zA-Z0-9+\-*/()]+ {
    char postfix[MAX];
    infixToPostfix(yytext, postfix);
    printf("Infix: %s -> Postfix: %s\n", yytext, postfix);
}
\n|\t|\r ; // Ignore whitespace characters
. ; // Ignore all other characters
%%

void push(char c) {
    if (top >= MAX - 1) {
        printf("Stack overflow\n");
        exit(1);
    }
    stack[++top] = c;
}

char pop() {
    if (top < 0) {
        printf("Stack underflow\n");
        exit(1);
    }
    return stack[top--];
}

int precedence(char c) {
    switch (c) {
        case '+':
        case '-': return 1;
        case '*':
        case '/': return 2;
        case '(': return 0;
        default: return -1;
    }
}

void infixToPostfix(const char *infix, char *postfix) {
    int i = 0, j = 0;
    char c;
    while ((c = infix[i++]) != '\0') {
        if (isalnum(c)) { // If operand, add to postfix
            postfix[j++] = c;
        } else if (c == '(') {
            push(c);
        } else if (c == ')') {
            while (top != -1 && stack[top] != '(') {
                postfix[j++] = pop();
            }
            if (top != -1 && stack[top] == '(') {
                pop(); // Pop '('
            }
        } else { // Operator
            while (top != -1 && precedence(c) <= precedence(stack[top])) {
                postfix[j++] = pop();
            }
            push(c);
        }
    }
    while (top != -1) { // Pop remaining operators
        postfix[j++] = pop();
    }
    postfix[j] = '\0'; // Null-terminate the postfix string
}

int main() {
    printf("Enter an infix expression:\n");
    yylex();
    return 0;
}
