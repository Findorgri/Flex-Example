%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
FILE *fout;
%}
%%
[+-]?[0-9]* {fprintf(fout, "I found an integer: %s", yytext);}
%%

void main(int argc, char** argv){
	if(argc<3){
		printf("\nError!!! Missing Command line arguments");
		printf("\nUsage exe <inputfile> <outputfile>");
		exit(1);
	}
	else{
		fout = fopen(argv[2], "w");
		yyin = fopen(argv[1], "r");
		yylex();
		}
}