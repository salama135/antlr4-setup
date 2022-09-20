grammar A2ML;

/*
 * Parser Rules
 */

tag
	:	STRING
	;

keyword
	:	STRING
	;

constant
	:	INT
	;

a2ml
	:	BEGIN A2ML 
		declaration* 
		END A2ML
	;

declaration
	:	type_definition SEMICOLON
	|	block_definition SEMICOLON	
	;

type_definition 
	:	type_name
	;

block_definition 
	:	BLOCK tag type_name
	;

type_name
	:	predefined_type_name 
	|	struct_type_name 
	|	taggedstruct_type_name 
	|	taggedunion_type_name 
	|	enum_type_name
	|	LEFT_PARENTHESES member RIGHT_PARENTHESES ASTERISK
	;

predefined_type_name
	:	CHAR_L 
	|	UCHAR_L 
	|	INT_L 
	|	UINT_L 
	|	LONG_L 
	|	ULONG_L 
	|	DOUBLE_L
	|	FLOAT_L
	;

enum_type_name 
	:	ENUM (IDENTIFIER)? LEFT_CURLY_BRACKET enumerator_list RIGHT_CURLY_BRACKET
	|	ENUM IDENTIFIER
	;

enumerator_list 
	:	enumerator
	|	enumerator COMMA enumerator_list
	;

// enumerator_list 
// 	:	(enumerator COMMA)* enumerator
// 	;

enumerator 
	:	keyword (EQUAL constant)?
	;


struct_type_name 
	:	STRUCT (IDENTIFIER)? LEFT_CURLY_BRACKET (struct_member_list)? RIGHT_CURLY_BRACKET 
	|	STRUCT IDENTIFIER
	;

struct_member_list
	:	struct_member
	|	struct_member struct_member_list
	;

// struct_member_list
// 	:	struct_member+ 
// 	;

struct_member 
	:	member SEMICOLON 
	;

member
	:	type_name (array_specifier)?
	;

array_specifier
	:	LEFT_SQUARE_BRACKET constant RIGHT_SQUARE_BRACKET 
	|	LEFT_SQUARE_BRACKET constant RIGHT_SQUARE_BRACKET array_specifier
	;

taggedstruct_type_name 
	:	TAGGEDSTRUCT (IDENTIFIER)? LEFT_CURLY_BRACKET (taggedstruct_member_list)? RIGHT_CURLY_BRACKET
	|	TAGGEDSTRUCT IDENTIFIER
	;

taggedstruct_member_list 
	:	taggedstruct_member
	|	taggedstruct_member	taggedstruct_member_list
	;

// taggedstruct_member_list 
// 	:	taggedstruct_member+ 
// 	;

taggedstruct_member 
	:	taggedstruct_definition SEMICOLON
	|	LEFT_PARENTHESES taggedstruct_definition? RIGHT_PARENTHESES ASTERISK SEMICOLON
	|	block_definition SEMICOLON 
	|	LEFT_PARENTHESES block_definition? RIGHT_PARENTHESES ASTERISK SEMICOLON
	;

taggedstruct_definition
	:	tag (member)? 
	|	tag LEFT_PARENTHESES member RIGHT_PARENTHESES ASTERISK SEMICOLON 
	;

taggedunion_type_name
	:	TAGGEDUNION (IDENTIFIER)? LEFT_CURLY_BRACKET (taggedunion_member_list)? RIGHT_CURLY_BRACKET 
	|	TAGGEDUNION IDENTIFIER 
	;

taggedunion_member_list 
	:	taggedunion_member 
	|	taggedunion_member taggedunion_member_list
	;

// taggedunion_member_list 
// 	:	taggedunion_member+ 
// 	;

taggedunion_member 
	:	taggedunion_definition SEMICOLON
	|	LEFT_PARENTHESES taggedunion_definition? RIGHT_PARENTHESES ASTERISK SEMICOLON
	|	block_definition SEMICOLON 
	|	LEFT_PARENTHESES block_definition? RIGHT_PARENTHESES ASTERISK SEMICOLON
	;

taggedunion_definition
	:	tag (member)? 
	|	block_definition SEMICOLON
	;

/*
 * Lexer Rules
 */

STRING 
	:	'"' IDENTIFIER '"'
	;

BLOCK
	:	'block'
	;

STRUCT 
	:	'struct'
	;

TAGGEDUNION
	:	'taggedunion'
	;

TAGGEDSTRUCT 
	:	'taggedstruct'
	;

A2ML
	:	'A2ML'
	;

IF_DATA 
	:	'IF_DATA'
	;

BEGIN 
	:	'/begin'
	;

END 
	:	'/end'
	;

INT_L
	:	'int'
	;

UINT_L
	:	'uint'
	;

CHAR_L
	:	'char'
	;

UCHAR_L
	:	'uchar'
	;

LONG_L
	:	'long'
	;

ULONG_L
	:	'ulong'
	;

FLOAT_L
	:	'float'
	;

DOUBLE_L
	:	'double'
	;


ENUM 
	:	'enum' 
	;

EQUAL
	:	'='
	;

COMMA
	:	','
	;

SEMICOLON
	:	';'
	;

LEFT_CURLY_BRACKET
	:	'{'
	;

RIGHT_CURLY_BRACKET
	:	'}'
	;

LEFT_SQUARE_BRACKET
	:	'['
	;

RIGHT_SQUARE_BRACKET
	:	']'
	;

LEFT_PARENTHESES
	:	'('
	;

ASTERISK
	:	'*'
	;

RIGHT_PARENTHESES
	:	')'
	;

HEX
	:	'0x' [a-fA-F0-9]+
	;

INT 
	:	'0' | [1-9] [0-9]*
	;

IDENTIFIER 
	:	[a-zA-Z_]+[a-zA-Z0-9_]*
	;

COMMENT 
	:	'/*' .*? '*/' -> skip
	;

COMMENT_LINE 
	:	'//' .*? NEWLINE  -> skip
	;

WS 
	:	(' '|'\t') -> skip
	;

NEWLINE 
	:	('\r'? '\n' | '\r')+ -> skip
	;