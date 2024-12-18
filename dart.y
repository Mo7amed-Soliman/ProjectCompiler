%token VOID MAIN INTEGER VARIABLE NUMBER PRINT IF ELSE  
%token EQUALS NOT_EQUALS GREATER_THAN LESS_THAN GREATER_EQUAL LESS_EQUAL NOT
%right '='
%left OR 
%left NOT AND
%left GREATER_THAN LESS_THAN  LESS_EQUAL GREATER_EQUAL EQUALS NOT_EQUALS
%left '+' '-'
%left '*' '/'
%left UMINUS 

%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex(void);
    void yyerror(char *);
    extern FILE *yyin;
    extern FILE *yyout;
    FILE *yyError;
    int sym[20]; // Symbol table for variable storage
%}

%%

program:
    VOID MAIN '(' ')' '{' statements '}' 
;

statements:
    /* empty  */
    | statement statements
;

statement: 
      declaration ';' 
    | declaring_and_initialising ';'
    | assignment ';' 
    | PRINT '(' expression ')' ';' { 
          fprintf(yyout, "Print: %d\n", $3); 
      }
    | expression ';' 
    | if_statements 
;

declaration:
    INTEGER VARIABLE { 
        fprintf(yyout, "Declaring variable: %c\n", 'a' + $2); 
        sym[$2] = 0; 
    }
;


declaring_and_initialising:
    INTEGER VARIABLE '=' expression { 
        fprintf(yyout, "Declaring and Initializing %c to %d\n", 'a' + $2, $4); 
        sym[$2] = $4;
    }
;

assignment: VARIABLE '=' expression  {
          fprintf(yyout, "Assigning value: %d to %c\n", $3, 'a' + $1);
          sym[$1] = $3; 
    }
;

expression:
    NUMBER { 
          $$ = $1; 
      }
    | VARIABLE { 
          $$ = sym[$1]; 
      }
    | expression '+' expression { 
          $$ = $1 + $3; 
          fprintf(yyout, "ADDITION: %d + %d = %d\n", $1, $3, $$); 
      }
    | expression '-' expression { 
          $$ = $1 - $3; 
          fprintf(yyout, "SUBTRACTION: %d - %d = %d\n", $1, $3, $$); 
      }
    | expression '*' expression { 
          $$ = $1 * $3; 
          fprintf(yyout, "MULTIPLICATION: %d * %d = %d\n", $1, $3, $$); 
      }
    | expression '/' expression { 
          if ($3 != 0) { 
              $$ = $1 / $3; 
              fprintf(yyout, "DIVISION: %d / %d = %d\n", $1, $3, $$); 
          } else { 
              $$ = 0;
              fprintf(yyError, "Runtime Error: Division by zero\n"); 
          }
      }
    | expression LESS_THAN expression { 
          $$ = $1 < $3; 
          fprintf(yyout, "LESS THAN: %d < %d = %d\n", $1, $3, $$); 
      }
    | expression GREATER_THAN expression { 
          $$ = $1 > $3; 
          fprintf(yyout, "GREATER THAN: %d > %d = %d\n", $1, $3, $$); 
      }
    | expression GREATER_EQUAL expression { 
          $$ = $1 >= $3;
          fprintf(yyout, "GREATER_EQUAL: %d >= %d = %d\n", $1, $3, $$); 
      }
    | expression LESS_EQUAL expression { 
          $$ = $1 <= $3;
          fprintf(yyout, "LESS_EQUAL: %d <= %d = %d\n", $1, $3, $$); 
      }
    | expression EQUALS expression { 
          $$ = ($1 == $3); 
          fprintf(yyout, "EQUALS: %d == %d = %d\n", $1, $3, $$); 
      }
    | expression NOT_EQUALS expression { 
          $$ = ($1 != $3); 
          fprintf(yyout, "NOT_EQUALS: %d != %d = %d\n", $1, $3, $$); 
      }
    | expression OR expression { 
          $$ = ($1 || $3); 
          fprintf(yyout, "OR: %d || %d = %d\n", $1, $3, $$); 
      }
    | expression AND expression { 
          $$ = ($1 && $3);
          fprintf(yyout, "AND: %d && %d = %d\n", $1, $3, $$);  
      }
    | '(' expression ')' { 
          $$ = $2; 
      }
    | '-' expression %prec UMINUS { 
          $$ = -$2;
          fprintf(yyout, "UMINUS: %d = %d\n", $2, $$);  
      }
     | '!' expression %prec NOT { 
        $$ = !$2;
        fprintf(yyout, "LOGICAL NOT: %d = %d\n", $2, $$);  
    }
;


if_statements:
      IF '(' expression ')' '{' statements '}' {
            fprintf(yyout, "Condition evaluated to: %d\n", $3);  // Debug 
            if($3) {
                fprintf(yyout, "If statement is true\n");
            } else {
                fprintf(yyout, "If statement is false\n");
            }
        }
    | IF '(' expression ')' '{' statements '}' ELSE '{' statements '}' {
            fprintf(yyout, "Condition evaluated to: %d\n", $3);  // Debug 
            if($3) {
                fprintf(yyout, "If statement is true\n");
            } else {
                fprintf(yyout, "If statement is false => else\n");
            }
        }
;




%%

void yyerror(char *s) {
    fprintf(yyError, "Error: %s\n", s);
}

int main(void) {
    yyin = fopen("in.txt", "r");
    yyout = fopen("out.txt", "w");
    yyError = fopen("outError.txt", "w");

    if (!yyin || !yyout || !yyError) {
        fprintf(stderr, "Error opening files.\n");
        exit(1);
    }

    yyparse();

    fclose(yyin);
    fclose(yyout);
    fclose(yyError);

    return 0;
}
