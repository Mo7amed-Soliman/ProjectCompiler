# Dart Compiler Project

This repository contains a compiler project built using Flex and Bison for parsing and lexical analysis. The files included demonstrate the steps required to parse and analyze Dart code.


## Prerequisites

- Flex: For generating the scanner.
- Bison: For generating the parser.
- GCC or any C compiler: To compile the generated C files.

  
## Files and Descriptions

- **dart.l**: Flex file for lexical analysis (scanner).
- **dart.y**: Bison file for grammar rules.
- **lex.yy.c**: Generated C file by Flex for scanning.
- **dart.tab.c**: Generated C file by Bison for parsing.
- **dart.tab.h**: Generated header file by Bison for parser definitions.
- **a.exe**: The compiled executable of the project.
- **in.txt**: Input file containing sample Dart code to test the compiler.
- **out.txt**: Output file containing results of the parsing process.
- **outError.txt**: Output file containing error messages from the parsing process.


## Grammar Rules

### Tokens
- **Keywords**: `VOID`, `MAIN`, `INTEGER`, `PRINT`, `IF`, `ELSE`
- **Operators**: `=`, `!=`, `<`, `>`, `<=`, `>=`, `+`, `-`, `*`, `/`, `!`, `&&`, `||`
- **Data Types**: `INTEGER`

### Supported Statements
- **Variable Declaration**: `int a;`
- **Variable Initialization**: `int a = 5;`
- **Assignment**: `a = 10;`
- **Print Statement**: `print(a + 5);`
- **If Statements**:
  ```c
  if (a < 10) {
      // statements
  }
  else {
      // statements
  }

  
## How to Run

1.Use Flex to generate the scanner:

    flex dart.l

2.Use Bison to generate the parser:

    bison -d dart.y

3.Compile the generated C files:

    gcc -o a.exe dart.tab.c lex.yy.c -lm

4.Run the executable with an input file:

    ./a.exe < in.txt

5.Check the output in out.txt and error logs in outError.txt.


