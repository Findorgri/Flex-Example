%option noyywrap

%x SINGLELINECOMMENTS
%x MULTIPLELINECOMMENTS
%x STRING

%{
#include <stdio.h>
#include <stdlib.h>
FILE *fout;
%}
%%

"\"" { fprintf(fout, "\""); BEGIN STRING; }
<STRING>"\""$ { fprintf(fout, "\"\n"); BEGIN INITIAL; }
<STRING>"\"" { fprintf(fout, "\""); BEGIN INITIAL; }
<STRING>. { fprintf(fout, "%s", yytext); }
<STRING>.$ { fprintf(fout, "%s\n", yytext); }


"/*" { BEGIN MULTIPLELINECOMMENTS; }
<MULTIPLELINECOMMENTS>"*/" { BEGIN INITIAL; }
<MULTIPLELINECOMMENTS>"*/"$ { fprintf(fout, "\n", yytext); BEGIN INITIAL; }
<MULTIPLELINECOMMENTS>. {  }

"//" { BEGIN SINGLELINECOMMENTS; }
<SINGLELINECOMMENTS>"\n" { BEGIN INITIAL; }
<SINGLELINECOMMENTS>. { }
<SINGLELINECOMMENTS>.$ { fprintf(fout, "\n", yytext); }

. { fprintf(fout, "%s", yytext); }
.$ { fprintf(fout, "%s\n", yytext); }

%%

void main( int argc, char ** argv){
	if ( argc < 3 ){
		printf("\nError!!! Missing Command line arguments");
		printf("\nUsage exe <inputfile> <outputfile>");
		exit(1);
	}
	else{
		fout = fopen(argv[2],"w");
		yyin = fopen(argv[1],"r");
		yylex();
	}
}