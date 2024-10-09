package cup.example;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java_cup.runtime.Symbol;
import java.lang.*;
import java.io.InputStreamReader;

%%
%class Lexer
%implements sym
%public
%unicode
%line
%column
%cup
%char
%{
	

    public Lexer(ComplexSymbolFactory sf, java.io.InputStream is){
		this(is);
        symbolFactory = sf;
    }
	public Lexer(ComplexSymbolFactory sf, java.io.Reader reader){
		this(reader);
        symbolFactory = sf;
    }
    
    private StringBuffer sb;
    private ComplexSymbolFactory symbolFactory;
    private int csline,cscolumn;

    public Symbol symbol(String name, int code){
		return symbolFactory.newSymbol(name, code,
						new Location(yyline+1,yycolumn+1, yychar), // -yylength()
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength())
				);
    }
    public Symbol symbol(String name, int code, String lexem){
	return symbolFactory.newSymbol(name, code, 
						new Location(yyline+1, yycolumn +1, yychar), 
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength()), lexem);
    }
    
    protected void emit_warning(String message){
    	System.out.println("scanner warning: " + message + " at : 2 "+ 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
    
    protected void emit_error(String message){
    	System.out.println("scanner error: " + message + " at : 2" + 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
%}

Newline    = \r | \n | \r\n
Whitespace = [ \t\f] | {Newline}
Number     = [0-9]+
integer = { Number }

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment}
TraditionalComment = "/*" {CommentContent} \*+ "/"
EndOfLineComment = "//" [^\r\n]* {Newline}
CommentContent = ( [^*] | \*+[^*/] )*

identifier = ([:jletter:] | "_" ) ([:jletterdigit:] | [:jletter:] | "_" )*


%eofval{
    return symbolFactory.newSymbol("EOF",sym.EOF);
%eofval}

%state CODESEG

%%  

<YYINITIAL> {
  
  "program"    { return symbolFactory.newSymbol("PROGRAM", PROGRAM); }
  "endprogram" { return symbolFactory.newSymbol("ENDPROGRAM", ENDPROGRAM); } 
  "function"   { return symbolFactory.newSymbol("FUNCTION", FUNCTION); }
  "endfunction" { return symbolFactory.newSymbol("ENDFUNCTION", ENDFUNCTION); }
  "if"	       { return symbolFactory.newSymbol("IF", IF); }	
  "then"       { return symbolFactory.newSymbol("THEN", THEN); }
  "else"       { return symbolFactory.newSymbol("ELSE", ELSE); }
  "endif"      { return symbolFactory.newSymbol("ENDIF", ENDIF); }
  "while"      { return symbolFactory.newSymbol("WHILE", WHILE); }
  "do"	       { return symbolFactory.newSymbol("DO", DO); }
  "enddo"      { return symbolFactory.newSymbol("ENDDO", ENDDO); }
  "for"	       { return symbolFactory.newSymbol("FOR", FOR); }		
  "to"	       { return symbolFactory.newSymbol("TO", TO); }	
  "endfor"     { return symbolFactory.newSymbol("ENDFOR", ENDFOR); }
  "return"     { return symbolFactory.newSymbol("RETURN", RETURN); }
  "string"     { return symbolFactory.newSymbol("STRING", STRING); }
  "integer"    { return symbolFactory.newSymbol("INT", INT); }
  "real"       { return symbolFactory.newSymbol("REAL", REAL); }
  "clear"      { return symbolFactory.newSymbol("CLEAR", CLEAR); }
  "move"       { return symbolFactory.newSymbol("MOVE", MOVE); }
  "draw"       { return symbolFactory.newSymbol("DRAW", DRAW); }
  "write"      { return symbolFactory.newSymbol("WRITE", WRITE); }
  "set"        { return symbolFactory.newSymbol("SET", SET); }
  "color"      { return symbolFactory.newSymbol("COLOR", COLOR); }
  "line"       { return symbolFactory.newSymbol("LINE", LINE); }
  "mod"	       { return symbolFactory.newSymbol("MOD", MOD); }	
  "and"        { return symbolFactory.newSymbol("AND", AND); }
  "or"	       { return symbolFactory.newSymbol("OR", OR); }
  "not"	       { return symbolFactory.newSymbol("NOT", NOT); }	
  
  {Whitespace} {                              }
  ":="         { return symbolFactory.newSymbol("ASSIGN", ASSIGN); }
  "\\*"	       { return symbolFactory.newSymbol("EXPONENT", EXPONENT); }
  "!="	       { return symbolFactory.newSymbol("NOT_EQUAL", NOT_EQUAL); }
  "<="	       { return symbolFactory.newSymbol("LESS_THAN_EQUAL", LESS_THAN_EQUAL); }
  ">="	       { return symbolFactory.newSymbol("GREATER_THAN_EQUAL", GREATER_THAN_EQUAL); }
  "/"	       { return symbolFactory.newSymbol("DIVIDE", DIVIDE); }
  "="          { return symbolFactory.newSymbol("EQUAL", EQUAL); }	
  "<"          { return symbolFactory.newSymbol("LESS_THAN", LESS_THAN); }
  ">"	       { return symbolFactory.newSymbol("GREATER_THAN", GREATER_THAN); }
  "{"          { return symbolFactory.newSymbol("CLPAREN", CLPAREN); }
  "}"	       { return symbolFactory.newSymbol("RLPAREN", RLPAREN); }
  ";"          { return symbolFactory.newSymbol("SEMI", SEMI); }
  ","          { return symbolFactory.newSymbol("COMMA", COMMA); }
  "+"          { return symbolFactory.newSymbol("PLUS", PLUS); }
  "-"          { return symbolFactory.newSymbol("MINUS", MINUS); }
  "*"          { return symbolFactory.newSymbol("TIMES", TIMES); }
  "("          { return symbolFactory.newSymbol("LPAREN", LPAREN); }
  ")"          { return symbolFactory.newSymbol("RPAREN", RPAREN); }
  "["          { return symbolFactory.newSymbol("BIGLPAREN", BIGLPAREN); }
  "]"          { return symbolFactory.newSymbol("BIGRPAREN", BIGRPAREN); }
  {Number}     { return symbolFactory.newSymbol("NUMBER", NUMBER, Integer.parseInt(yytext())); } 
  {identifier} { return symbolFactory.newSymbol("ID", ID, yytext()); }
  
}


// error fallback
.|\n          { emit_warning("Unrecognized character '" +yytext()+"' -- ignored"); }
