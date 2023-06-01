%{
    #include "pharo.hpp"
    #include "pharo.parser.hpp"

    char* yyfile = nullptr;
%}

%option noyywrap yylineno

%%
#.*             {}                  // line comment
[ \t\r\n\f]+    {}                  // drop spaces

"nop"           CMD(nop)
"halt"          CMD(halt)

.               {yyerror("");}      // any undetected char
