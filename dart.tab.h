#ifndef DART_TAB_H
#define DART_TAB_H

/* Token Definitions */
#define VOID 258
#define MAIN 259
#define INTEGER 260
#define VARIABLE 261
#define NUMBER 262
#define PRINT 263
#define IF 264  
#define ELSE 265

#define EQUALS 266
#define NOT_EQUALS 267
#define GREATER_THAN 268  
#define LESS_THAN 269
#define GREATER_EQUAL 270  
#define LESS_EQUAL 271

#define AND 272  
#define OR 273
#define UMINUS 274  
#define NOT 275
#define FOR 276



/* Define YYSTYPE if not already defined */
#ifndef YYSTYPE
#define YYSTYPE int
#endif

/* Declare external yylval */
extern YYSTYPE yylval;

#endif /* DART_TAB_H */
