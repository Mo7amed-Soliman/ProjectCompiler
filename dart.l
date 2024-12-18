%{
    #include<stdio.h>
    #include<stdlib.h>  
    #include "dart.tab.h"  
    extern YYSTYPE yylval;
 
%}

%%

"void"       { return VOID; }
"main"       { return MAIN; }
"int"        { return INTEGER; }

"print"      { return PRINT; }

"if"         { return IF; }
"else"       { return ELSE; }
"for"        { return FOR; }

[a-zA-Z] {
    yylval = *yytext - 'a'; 
    return VARIABLE;
}

"=="         { return EQUALS; }
"!="         { return NOT_EQUALS; }
">"          { return GREATER_THAN; }
"<"          { return LESS_THAN; }
">="         { return GREATER_EQUAL; }
"<="         { return LESS_EQUAL; }
"&&"         { return AND; }
"||"         { return OR; }

[0-9]+ {
    yylval = atoi(yytext);    
    return NUMBER;
}

[-+/*=();!] {
    return *yytext;
}

"{"          { return '{'; }
"}"          { return '}'; }

[ \t\n]+     { /* Ignore whitespace */ }
"//".*       { /* Ignore comments */ }
.            { /* Ignore unrecognized characters */ }

%%

int yywrap() {
    return 1;
}
