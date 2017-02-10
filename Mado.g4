grammar Mado;

expr: '(' expr ')'                       #parenExpr
    | number variable                    #multiplyExpr
    | lop=expr op=('*'|'/') rop=expr     #operatorExpr
    | lop=expr op=('+'|'-') rop=expr     #operatorExpr
    | number                             #atomNumberExpr
    | variable                           #atomVariableExpr
    ;

number: Number;
variable: Variable;

Number: [0-9]+;
Variable: ('W'|'H'|'x'|'y'|'w'|'h');
WHITESPACE: ('\t'|' '|'\u000C')+ -> skip;
