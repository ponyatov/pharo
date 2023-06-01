#pragma once

#include <assert.h>
#include <dlfcn.h>
#include <cxxabi.h>

#include <string>
#include <iostream>
#include <sstream>

// init
extern int main(int argc, char* argv[]);    ///< program entry point
extern void init(int& argc, char* argv[]);  ///< system initialize
extern int fini(int err = 0);               ///< system finalize & exit
extern void arg(int argc, char* argv);      ///< print command line argument

// skelex
extern FILE* yyin;
extern char* yyfile;
extern int yylineno;
extern char* yytext;
extern int yyparse();
extern void yyerror(std::string msg);

/// VM command
#define CMD(C)        \
    {                 \
        yylval.c = C; \
        return CMD0;  \
    }

// VM
extern std::string p2name(void (*p)());  ///< return function name

extern void nop();   ///< `( -- )` do nothing
extern void halt();  ///< `( -- )` stop the system
