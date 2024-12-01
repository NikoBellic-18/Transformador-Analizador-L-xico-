/** Seccion de definiciones **/
%{
#include <stdio.h>
#include <string.h>
FILE *input_archivo_minimizado;
FILE *ouput_archivo_extendido;
%}

/** Seccion de reglas **/
%%
[a-z][a-zA-Z0-9]{0,10}	{fprintf(yyout, "%s", yytext);}
-?[0-9]{0,10}			{fprintf(yyout, "%s", yytext);}
-?[0-9]+\.[0-9]+		{fprintf(yyout, "%s", yytext);}
\'[^\']*\'			{fprintf(yyout, "%s", yytext);}
[\[\]\{\}\$]			{fprintf(yyout, "%s", yytext);}
"+"				{fprintf(yyout, " sumar ");}
" - "				{fprintf(yyout, " restar ");}
"*"				{fprintf(yyout, " multiplicar ");}
"/"				{fprintf(yyout, " dividir ");}
"%"				{fprintf(yyout, " modulo ");}
"&"				{fprintf(yyout, " operadorlogico_y ");}
"|"				{fprintf(yyout, " operadorlogico_o ");}
"!"				{fprintf(yyout, " operadorlogico_diferente ");}
"==="   			{fprintf(yyout, " igual ");}
"="  				{fprintf(yyout, " equivale_a ");}
"!="				{fprintf(yyout, " diferente ");}
"<"				{fprintf(yyout, " menor ");}
"<="				{fprintf(yyout, " menor_igual ");}
">"				{fprintf(yyout, " mayor ");}
">="				{fprintf(yyout, " mayor_igual ");}
"if "				{fprintf(yyout, " condicional_si ");}
"for "				{fprintf(yyout, " condicional_para ");}
"while "			{fprintf(yyout, " condicional_mientras" );}
"else "				{fprintf(yyout, " de_otro_modo ");}
"elif "				{fprintf(yyout, " condicional_sino ");}
"function "			{fprintf(yyout, " funcion ");}
"class "			{fprintf(yyout, " clase ");}
"var "				{fprintf(yyout, " declaracion_variable ");}
"print "			{fprintf(yyout, " imprimir ");}
"input "			{fprintf(yyout, " leer ");}
"return "			{fprintf(yyout, " retornar ");}
[\n]				{fprintf(yyout, "\n");}
[ \t]				{ /* Ignorar tabulaciones */ }
%%

/** Seccion de codigo de usuario **/
int main(int argc, char **argv){
	if(argc < 3){
		fprintf(stderr, "Ingrese %s archivo_minimizado && archivo_para_extender\n", argv[0]);
		return 1;
	}
	
	input_archivo_minimizado = fopen(argv[1], "r");
	if(!input_archivo_minimizado){
		perror("Error al abrir el archivo de entrada minimizado");
		return 1;
	}
	
	ouput_archivo_extendido = fopen(argv[2], "w");
	if(!ouput_archivo_extendido ){
		perror("Error al abrir el archivo de salida extendido");
		return 1;
	}
	
	yyin = input_archivo_minimizado;
	yyout = ouput_archivo_extendido;
	yylex();
	
	fclose(input_archivo_minimizado);
	fclose(ouput_archivo_extendido);
	
	return 0;
}
