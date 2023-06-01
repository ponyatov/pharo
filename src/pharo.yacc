%{
    #include "pharo.hpp"
    #include "pharo.lexer.hpp"
%}

%defines %union { void (*c)(); }

%token<c> CMD0

%%
syntax :
       | syntax CMD0    { std::cerr << fn($2) << std::endl; $2(); }
