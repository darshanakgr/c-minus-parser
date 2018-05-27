%{                                                                                   
   #include <stdarg.h> 
   #include "c_minus_shared.h"                                                        
   #define YYSTYPE char *                                                            
   int indent=0;
   int yydebug=0;                                                                    
   char *iden_dum;                                                                   
%} 

%token ELSE
%token IF
%token INT
%token RETURN
%token VOID
%token WHILE
%token PLUS
%token MINUS
%token MUL
%token DIV
%token GREATER_THAN
%token GREATER_THAN_OR_EQ
%token LESS_THAN
%token LESS_THAN_OR_EQ
%token EQ
%token NOT_EQ
%token ASSIGNMENT
%token SEMI_COLON
%token COMMA
%token OPEN_CURLY_BRACE
%token CLOSE_CURLY_BRACE
%token OPEN_PARANTHESIS
%token CLOSE_PARANTHESIS
%token OPEN_SQUARE_BRACKETS
%token CLOSE_SQUARE_BRACKETS
%token IDENTIFIER
%token NUM
%start program

%%

program				: declaration-list
					| %empty;

declaration-list	: declaration-list declaration | declaration;

declaration			: var-declaration | fun-declaration;

var-declaration		: type-specifier IDENTIFIER SEMI_COLON 
					| type-specifier IDENTIFIER OPEN_SQUARE_BRACKETS NUM CLOSE_SQUARE_BRACKETS SEMI_COLON;
					
type-specifier		: INT 
					| VOID;
					
fun-declaration		: type-specifier IDENTIFIER OPEN_PARANTHESIS params CLOSE_PARANTHESIS compound-stmt;

params				: param-list 
					| VOID;
					
param-list			: param-list COMMA param 
					| param ;
					
param				: type-specifier IDENTIFIER 
					| type-specifier IDENTIFIER OPEN_SQUARE_BRACKETS CLOSE_SQUARE_BRACKETS;
						
compound-stmt		: OPEN_CURLY_BRACE local-declarations statement-list CLOSE_CURLY_BRACE;

local-declarations	: local-declarations var-declaration 
					| %empty;
					
statement-list		: statement-list statement 
					| %empty;
					
statement			: expression-stmt 
					| compound-stmt 
					| selection-stmt 
					| iteration-stmt 
					| return-stmt;
					
expression-stmt		: expression SEMI_COLON 
					| SEMI_COLON;
					
selection-stmt		: IF OPEN_PARANTHESIS expression CLOSE_PARANTHESIS statement
					| IF OPEN_PARANTHESIS expression CLOSE_PARANTHESIS statement ELSE statement;
					
iteration-stmt		: WHILE OPEN_PARANTHESIS expression CLOSE_PARANTHESIS statement;

return-stmt			: RETURN SEMI_COLON 
					| RETURN expression SEMI_COLON;
					
expression			: var ASSIGNMENT expression 
					| simple-expression;
					
var					: IDENTIFIER 
					| IDENTIFIER OPEN_SQUARE_BRACKETS expression CLOSE_SQUARE_BRACKETS;
					
simple-expression	: additive-expression relop additive-expression 
					| additive-expression;      
					
relop				: LESS_THAN 
					| LESS_THAN_OR_EQ 
					| GREATER_THAN 
					| GREATER_THAN_OR_EQ 
					| EQ 
					| NOT_EQ;
					
additive-expression	: additive-expression addop term
					| term;
					
addop				: PLUS 
					| MINUS;

term				: term mulop factor 
					| factor;
					
mulop				: MUL 
					| DIV;
					
factor				: OPEN_PARANTHESIS expression CLOSE_PARANTHESIS 
					| var 
					| call 
					| NUM;   
					
call				: IDENTIFIER OPEN_PARANTHESIS args CLOSE_PARANTHESIS;

args				: arg-list 
					| %empty;
					
arg-list			: arg-list COMMA expression 
					| expression; 
					
%%

void yyerror(char *e){
    fprintf(stderr, "%s", e);
	return;
}

int main(void){
    if(yyparse() == 0){
        printf("Parsing Success\n");
		return 0;
    }else{
        printf(" at line %d\n", line_number);
		return 1;
    }
}