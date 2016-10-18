%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
FILE *fout;
%}
%%
(\"[A-z]+([A-z]*|[0-9]*|_*)\.(([a-z]|[0-9]){1,3})\")|('[A-z]+([A-z]*|[0-9]*|_*)\.(([a-z]|[0-9]){1,3})') {fprintf(fout, "I found a filename: %s", yytext);}
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