#include "pharo.hpp"

int main(int argc, char* argv[]) {
    init(argc, argv);
    for (int i = 1; i < argc; i++) {
        arg(i, argv[i]);
        yyfile = argv[i];
        assert(yyin = fopen(argv[i], "r"));
        yyparse();
        fclose(yyin);
    }
    return fini();
}

void yyerror(std::string msg) {
    std::cerr << "\n\n"
              << yyfile << ':' << yylineno << " [" << yytext << "]\n\n";
    exit(-1);
}

void arg(int argc, char* argv) {  //
    std::cerr << "argv[" << argc << "] = <" << argv << ">\n";
}

void init(int& argc, char* argv[]) { arg(0, argv[0]); }

int fini(int err) { return err; }

std::string p2name(void (*p)()) {
    std::ostringstream os;
    os << (void*)p << '\t';
    Dl_info dl;
    if (dladdr((void*)p, &dl))
        os << abi::__cxa_demangle(dl.dli_sname, 0, 0, nullptr);
    // os << std::endl;
    return os.str();
}

void nop() {}
void halt() { exit(fini()); }
