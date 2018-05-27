%{
    #include "c_minus.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
	extern int line_number;                                                                     
%}                                                                                          
%option noyywrap 

%%
"else"          {return ELSE;}
"if"            {return IF;}
"int"           {return INT;}
"return"        {return RETURN;}
"void"          {return VOID;}
"while"         {return WHILE;}
"+"             {return PLUS;}
"-"             {return MINUS;}
"*"             {return MUL;}
"/"             {return DIV;}
">"             {return GREATER_THAN;}
">="            {return GREATER_THAN_OR_EQ;}
"<"             {return LESS_THAN;}
"<="            {return LESS_THAN_OR_EQ;}
"=="            {return EQ;}
"!="            {return NOT_EQ;}
"="             {return ASSIGNMENT;}
";"             {return SEMI_COLON;}
","             {return COMMA;}
"{"             {return OPEN_CURLY_BRACE;}
"}"             {return CLOSE_CURLY_BRACE;}
"("             {return OPEN_PARANTHESIS;}
")"             {return CLOSE_PARANTHESIS;}
"["             {return OPEN_SQUARE_BRACKETS;}
"]"             {return CLOSE_SQUARE_BRACKETS;}
[a-zA-Z]+       {return IDENTIFIER;}
[0-9]+          {return NUM;}
[ \t\r]         {;}
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]	{line_number += newLineCount(yytext);}
[\n] 			{line_number++;}
.               {printf("Unexpected Token at line: %d\n", line_number);}       
%%

int newLineCount(char *string){
    int count;
    for (count=0; string[count]; string[count]=='\n' ? count++ : *string++);
    return count;
}