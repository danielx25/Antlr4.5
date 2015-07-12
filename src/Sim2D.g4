grammar Sim2D;

@parser::header
{
	package gramatica;
	import java.util.Vector;
}
@lexer::header
{
	package gramatica;
}
@parser::members
{
	//private static Sim2DTipoDato dato_nulo = new Sim2DTipoDato("<Nulo>");
}

DIVICION: '/';
MULTIPLICACION: '*';
SUMA: '+';
RESTA: '-';
ASIGNAR: '<-';
IGUAL: '=';
DIFERENTE: '!=';
MENOR: '<';
MAYOR: '>';
MENORIGUAL: '<=';
MAYORIGUAL: '>=';
COMA: ',';
PUNTOYCOMA: ';';
DEREF: '.';
PARENTESIS_IZQ: '(';
PARENTESIS_DER: ')';
CORCHETE_IZQ: '{';
CORCHETE_DER: '}';

/*Palabras reservadas */
OBJETO: 'objeto';
REGLA: 'regla';
FUNCION: 'funcion';
SI: 'si';
ENTONCES: 'entonces';
Y: 'and';
O: 'or';
VERDADERO: 'verdadero';
FALSO: 'falso';

ID: ('a'..'z' | 'A'..'Z' | 'ñ' | 'Ñ') ('a'..'z' | 'A'..'Z' | 'ñ' | 'Ñ' | '_' | '0'..'9') *;
NUMERO: (DIGITO)+ ('.' (DIGITO+))? EXPONENTE?;
EXPONENTE: ('e' | 'E') ('+' | '-')? DIGITO+;
DIGITO: '0'..'9';
CADENA: '"' .*? '"'; //falta que no se inclullan las comillas en el reconocimiento

NUEVA_LINEA: ('\n' | '\r') ->skip;
ESPACIOS_BLANCOS: (' ' | '\t') ->skip;
COMENTARIOS: (('/*' .*? '*/') | ('//' ~('\n')*)) ->skip;

//archivo: NUMERO;
archivo: (objeto_declarar | regla_declarar | funcion_declarar)+;

/* Las 3 partes principales del archivo, objeto, regla y funcion */
objeto_declarar:	OBJETO ID
							CORCHETE_IZQ
								(asignacion)*
							CORCHETE_DER;
							
regla_declarar:		REGLA ID
							CORCHETE_IZQ
								subagrupado
							CORCHETE_DER;
							
funcion_declarar:	FUNCION ID argumentosFuncion
							CORCHETE_IZQ
								subagrupado
							CORCHETE_DER;

/* Asignacion ej: velocidad <- 53;*/
asignacion: id ASIGNAR expresion PUNTOYCOMA;

condicional:	SI expresion
					CORCHETE_IZQ
						subagrupado
					CORCHETE_DER
					(ENTONCES
					CORCHETE_IZQ
						subagrupado
					CORCHETE_DER)?;

/* Argumentos en una funcion */
argumentosFuncion: PARENTESIS_IZQ lista_argumentos_funcion PARENTESIS_DER;
lista_argumentos_funcion: ID (COMA ID)*;

/* Pueden estar dentro de otros como en funciones, reglas y condicionales */
subagrupado: (cualquier_declaracion)*;
cualquier_declaracion:		condicional
									|	asignacion
									|	llamadaFuncion PUNTOYCOMA;

/* Llamada a funcion */
llamadaFuncion: ID argumento; //identificador(exprecion)
argumento: PARENTESIS_IZQ lista_argumento? PARENTESIS_DER;
lista_argumento: expresion (COMA expresion)*;

id: ID (DEREF ID)*;

expresion: and (O and)*;
and: comparadores (Y comparadores)*;
comparadores: operacionSumaResta ((IGUAL | DIFERENTE | MENOR | MAYOR | MAYORIGUAL | MENORIGUAL) operacionSumaResta)?;
operacionSumaResta: operacionMultiplicacionDivicion ((SUMA | RESTA) operacionMultiplicacionDivicion)*;
operacionMultiplicacionDivicion: signo ((MULTIPLICACION | DIVICION) signo)*;
signo:	SUMA dereferencia
		|	RESTA dereferencia
		|	dereferencia;
dereferencia: constante (DEREF constante)*;
constante: NUMERO | CADENA | VERDADERO | FALSO | id | llamadaFuncion | PARENTESIS_IZQ expresion PARENTESIS_DER;