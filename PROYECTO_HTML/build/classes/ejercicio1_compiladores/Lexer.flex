
package ejercicio1_compiladores;
import java.util.ArrayList;
import java_cup.runtime.Symbol;

%%
%public 
%class Lexer
%extends sym
%cupsym sym
%cup
%char
%column
%full
%ignorecase
%line
%unicode



%state   ESTADO1, ESTADO2, ESTADO3, ESTADO4, ESTADO5, ESTADO6, ESTADO7, ESTADO8,ESTADO9, ETIQUETA_CIERRE,ETIQUETA_INICIO
%state   STYLE1,STYLE2,STYLE3,STYLE4,STYLE5,STYLE6,STYLE7
%state   SCRIPT1,SCRIPT2,SCRIPT3,SCRIPT4
%state   DECLARACIONES1,DECLARACIONES2,DECLARACIONES3,DECLARACIONES4,DECLARACIONES5
%state   CONTROL_FLUJO1,CONTROL_FLUJO2,CONTROL_FLUJO3,CONTROL_FLUJO4,CONTROL_FLUJO5,CONTROL_FLUJO6,CONTROL_FLUJO7
%state   FUNCION1,FUNCION2,FUNCION3,FUNCION4,FUNCION5,FUNCION6,FUNCION7
%state   FOR1,FOR2,FOR3,FOR4,FOR5,FOR6,FOR7,FOR8
%state   COMENTARIO1,COMENTARIOFOR2
L = [a-zA-Zá-úÁ-Ú]
D = [0-9]

ALFANUMERICO = ({L}|{D}|":"|"."|"("|")"|";"|"-"|"\'"| "_" | "//"|"/"|"-"|"="|{WHITE})
WHITE = [ \t\r\n]
CSS_PROPIEDAD=          ("color"|"background"|"font-family"|"font-size"|"width"|"height")
RAIZ_HTML=              ("html")
HEAD=                   ("head")
BODY=                   ("body")
STYLE=                  ("style")
INPUT=                  ("input")
TITLE=                  ("title")
METADATOS_HTML=         ("base"|"link"|"meta")
HR=                     ("hr")


SCRIPT=                  ("script")
CONDICION_JS =          ("&&" | "||" | "!" | "==" |"===" | "<" | ">" | "<=" | ">=" |"!=")
OPE_ART_JS=             ("+"| "/" | "**" | "*" | "%" | "%" | "-" )
DECLACRACION_VAR_JS=         ("var"|"let"|"const" )
FUNCIONES_JS=                ("function")

IF=                          ("if")
ELSE=                        ("else")
BOOLEAN=                     ("true"|"false")
WHILE=                       ("while")
FOR=                       ("for")

          
SECCIONES_HTML=         ("article"|"section"|"nav"|"aside"|"h1"|"h2"|"h3"|"h4"|"h5"|"h6"|"hgroup"|"header"|"footer"|"address")
AGRUPACIONES_HTML=      ("p"|"pre"|"blockquote"|"ol"|"ul"|"menu"|"li"|"dl"|"dt"|"dd"|"figure"|"figcaption"|"main"|"div")

SEMANTICA_TEXTO_HTML=   ("a"|"em"|"strong"|"small"|"s"|"cite"|"q"|"dfn"|"abbr"|"ruby"|"rt"|"rp"|"data"|"time"|"code"|"var"|"samp"|"kbd"|"sub"|"sup"|"i"|"b"|"u"|"mark"|"bdi"|"bdo"|"span"|"br"|"wbr")
EDICION_HTML=           ("ins"|"del")
CONT_INCRUSTADO=        ("picture"|"source"|"img"|"iframe"|"embed"|"object"|"param"|"video"|"audio"|"track"|"map"|"area")
OBJ_TAB_HTML=           ("table"|"caption"|"colgroup"|"col"|"tbody"|"thead"|"tfoot"|"tr"|"td"|"th")
FORMULARIO_HTML=        ("form"|"label"|"button"|"select"|"datalist"|"optgroup"|"option"|"textarea"|"output"|"progress"|"meter"|"fieldset"|"legend")
ELM_INTERAC_HTML=       ("details"|"summary"|"dialog")
PROGRAMAS_HTML=         ("noscript"|"template"|"slot"|"canvas")

NOM_ETIQUETAS = ({SECCIONES_HTML} | {AGRUPACIONES_HTML} | {SEMANTICA_TEXTO_HTML} | {EDICION_HTML} | {CONT_INCRUSTADO} | {OBJ_TAB_HTML} | {FORMULARIO_HTML} | {ELM_INTERAC_HTML} | {PROGRAMAS_HTML})

/*ATRIBUTOS_HTML       =      (""|({WHITE}{1}{L}+("=")(("\"")(""|{ALFANUMERICO})+("\""){WHITE}*))*)*/
ATRIBUTOS_HTML       =   ("accept-charset"|"role"|"aria-hidden"|"scrolling"|"accesskey"|"action"|"align"|"alt"|"async"|"autocomplete"|"autofocus"|"autoplay"|"bgcolor"|"border"|"accept"|"charset"|"checked"|"cite"|"class"|"color"|"cols"|"colspan"|"content"|"contenteditable"|"controls"|"coords"|"data"|"datetime"|"default"|"defer"|"dir"|"dirname"|"disabled"|"download"|"draggable"|"dropzone"|"enctype"|"for"|"form"|"formaction"|"headers"|"height"|"hidden"|"high"|"href"|"hreflang"|"http-equiv"|"id"|"ismap"|"kind"|"label"|"lang"|"list"|"loop"|"low"|"max"|"maxlength"|"media"|"method"|"min"|"multiple"|"muted"|"name"|"novalidate"|"onabort"|"onafterprint"|"onbeforeprint"|"onbeforeunload"|"onblur"|"oncanplay"|"oncanplaythrou"|"onchange"|"onclick"|"oncontextmenu"|"oncopy"|"oncuechange"|"oncut"|"ondblclick"|"ondrag"|"ondragend"|"ondragenter"|"ondragleave"|"ondragover"|"ondragstart"|"ondrop"|"ondurationchan"|"onemptied"|"onended"|"onerror"|"onfocus"|"onhashchange"|"oninput"|"oninvalid"|"onkeydown"|"onkeypress"|"onkeyup"|"onload"|"onloadeddata"|"onloadedmetada"|"onloadstart"|"onmousedown"|"onmousemove"|"onmouseout"|"onmouseover"|"onmouseup"|"onmousewheel"|"onoffline"|"ononline"|"onpagehide"|"onpageshow"|"onpaste"|"onpause"|"onplay"|"onplaying"|"onpopstate"|"onprogress"|"onratechange"|"onreset"|"onresize"|"onscroll"|"onsearch"|"onseeked"|"onseeking"|"onselect"|"onstalled"|"onstorage"|"onsubmit"|"onsuspend"|"ontimeupdate"|"ontoggle"|"onunload"|"onvolumechange"|"onwaiting"|"onwheel"|"open"|"optimum"|"pattern"|"placeholder"|"poster"|"preload"|"readonly"|"rel"|"required"|"reversed"|"rows"|"rowspan"|"sandbox"|"scope"|"selected"|"shape"|"size"|"sizes"|"span"|"spellcheck"|"src"|"srcdoc"|"srclang"|"srcset"|"start"|"step"|"style"|"tabindex"|"target"|"title"|"translate"|"type"|"usemap"|"value"|"width"|"wrap")


%{

StringBuilder string_tag = new StringBuilder();
StringBuilder contenido_etiqueta= new StringBuilder();
StringBuilder Nom_Etiqueta= new StringBuilder();
StringBuilder Nom_atributo= new StringBuilder();
StringBuilder Nom_Var_Atributo= new StringBuilder();
public static String lexeme;
public static String nom_etiqueta="";
public static int posicion_etiquetas=0;
public static String nombre_fun="";
public static int nextState;
public static ArrayList<Integer> ArrayListMesas = new ArrayList<Integer>();


%}






%%





<YYINITIAL> {


  "<"             { 
                   yybegin(ESTADO1);
                   lexeme = yytext();
                   return new Symbol(lt ,yycolumn, yyline, yytext());
                   }
  "<!--"             { 
                   yybegin(COMENTARIO1);
                 
                   }

 "("                             {lexeme = yytext(); return new Symbol(lparen,yycolumn, yyline, yytext()); }
  ")"                            {lexeme = yytext(); return new Symbol(rparen,yycolumn, yyline, yytext()); }
  "{"                            {lexeme = yytext(); return new Symbol(lbrace,yycolumn, yyline, yytext()); }
  "}"                            {lexeme = yytext(); return new Symbol(rbrace,yycolumn, yyline, yytext()); }
  "["                            {lexeme = yytext(); return new Symbol(lbrack,yycolumn, yyline, yytext()); }
  "]"                            {lexeme = yytext(); return new Symbol(rbrack,yycolumn, yyline, yytext()); }
  ";"                            {System.out.println("basura" + nextState);
                                    lexeme = yytext(); return new Symbol(semicolon,yycolumn, yyline, yytext()); }
  ","                            {lexeme = yytext(); return new Symbol(coma,yycolumn, yyline, yytext()); }
  "."                            {lexeme = yytext(); return new Symbol(dot,yycolumn, yyline, yytext()); }
  
  /* operators */
  "="                            {lexeme = yytext(); return new Symbol(eq,yycolumn, yyline, yytext()); }
  ">"                            {lexeme = yytext(); return new Symbol(gt,yycolumn, yyline, yytext()); }
  "!"                            {lexeme = yytext(); return new Symbol(not,yycolumn, yyline, yytext()); }
  "~"                            {lexeme = yytext(); return new Symbol(comp,yycolumn, yyline, yytext()); }
  "?"                            {lexeme = yytext(); return new Symbol(question,yycolumn, yyline, yytext()); }
  ":"                            {lexeme = yytext(); return new Symbol(colon,yycolumn, yyline, yytext()); }
  "+"                            {lexeme = yytext(); return new Symbol(plus,yycolumn, yyline, yytext()); }
  "-"                            {lexeme = yytext(); return new Symbol(minus,yycolumn, yyline, yytext()); }
  "*"                            {lexeme = yytext(); return new Symbol(mult,yycolumn, yyline, yytext()); }
  "/"                            {lexeme = yytext(); return new Symbol(div,yycolumn, yyline, yytext()); }
  "&"                            {lexeme = yytext(); return new Symbol(and,yycolumn, yyline, yytext()); }
  "|"                            {lexeme = yytext(); return new Symbol(or,yycolumn, yyline, yytext()); }
  "^"                            {lexeme = yytext(); return new Symbol(xor,yycolumn, yyline, yytext()); }
  "%"                            {lexeme = yytext(); return new Symbol(mod,yycolumn, yyline, yytext()); }
  "@"                            {lexeme = yytext(); return new Symbol(arroba,yycolumn, yyline, yytext()); }


 {L}+                           {
                                    lexeme=yytext();
                                    return new Symbol(palabra,yycolumn, yyline, yytext());
                                }        

  {D}+                           { lexeme = yytext(); return new Symbol(digito,yycolumn, yyline, yytext()); }

  
   

                       

}

<ESTADO1> {

    [/]                 {
                        string_tag.append( yytext());
                        yybegin(ESTADO7);
                     
                        lexeme=yytext();
                        return new Symbol(div,yycolumn, yyline, yytext());
                        }


    {NOM_ETIQUETAS}     {
                        
                        string_tag.append(yytext());
                        lexeme=yytext();
                     
                        yybegin(ESTADO2);
                        return new Symbol(nombre_etiqueta,yycolumn, yyline, yytext());
                        }

    {RAIZ_HTML}     { 
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(html_r,yycolumn, yyline, yytext());
                        }
    {HEAD}     { 
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(html_h,yycolumn, yyline, yytext());
                        }
    {BODY}     { 
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(html_b,yycolumn, yyline, yytext());
                        }
    {STYLE}     { 
                        nom_etiqueta=yytext();
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(style,yycolumn, yyline, yytext());
                        }

    {SCRIPT}            { 
                        nom_etiqueta=yytext();
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(script,yycolumn, yyline, yytext());
                        }

    {INPUT}             { 
                        
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(input,yycolumn, yyline, yytext());
                        }
    {METADATOS_HTML}             { 
                        
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(etiquetas_head,yycolumn, yyline, yytext());
                        }
    {TITLE}             { 
                        
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(etiqueta_title,yycolumn, yyline, yytext());
                        }
    {HR}             { 
                        
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(etiqueta_hr,yycolumn, yyline, yytext());
                        }

    [^]                 {
                         string_tag.setLength(0);
                         yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                         yybegin(YYINITIAL);
                        }
}

<ESTADO2>{
    {WHITE}+    {yybegin(ESTADO3);}
    
    ">"         { 
                string_tag.append( yytext() );
                lexeme=yytext();
                yybegin(ETIQUETA_INICIO);
                return new Symbol(gt,yycolumn, yyline, yytext());
                }
    [^]         {
                string_tag.setLength(0);
                yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                yybegin(YYINITIAL);
                }
}


<ESTADO3>{
    {ATRIBUTOS_HTML}    { 
                        string_tag.append( yytext() );
                        lexeme=yytext();
                        yybegin(ESTADO4);
                        return new Symbol(atributo,yycolumn, yyline, yytext());
                        }
    
    [^]                 {
                        string_tag.setLength(0);
                        yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                        yybegin(YYINITIAL);
                        }
}


<ESTADO4>{
    {WHITE}+            {yybegin(ESTADO4);}

    "="                 { 
                        string_tag.append( yytext() );
                        lexeme=yytext();
                        yybegin(ESTADO5);
                        return new Symbol(eq,yycolumn, yyline, yytext());
                        }

    [^]                 {
                        string_tag.setLength(0);
                        yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                        yybegin(YYINITIAL);
                        }
}

<ESTADO5>{
    {WHITE}+                {
                            yybegin(ESTADO5);
                            }

    "\""{ALFANUMERICO}+"\"" { 
                            string_tag.append( yytext() );
                            lexeme=yytext();
                            yybegin(ESTADO6);
                            return new Symbol(valor_atributo,yycolumn, yyline, yytext());
                            }

    [^]                     {
                            string_tag.setLength(0);
                            yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                            yybegin(YYINITIAL);
                            }
}

<ESTADO6>{
    {WHITE}+                {
                            yybegin(ESTADO9);
                            }

    ">"                     {
                            string_tag.append( yytext() );
                            lexeme=yytext();
                            yybegin(ETIQUETA_INICIO);
                             return new Symbol (gt,yycolumn, yyline, yytext());
                            }

   [^]                      {
                            string_tag.setLength(0);
                            yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                            yybegin(YYINITIAL);
                            }
}

<ESTADO9>{
    {ATRIBUTOS_HTML}        { 
                            string_tag.append( yytext() );
                            lexeme=yytext();
                            yybegin(ESTADO4);
                            return new Symbol(atributo,yycolumn, yyline, yytext());
                            }

    [^]                      {
                            string_tag.setLength(0);
                            yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                            yybegin(YYINITIAL);
                            }
    

}

<ETIQUETA_INICIO>{
        
    .                  {

                       
                          System.out.println(nom_etiqueta);
                           
                          if(nom_etiqueta.equals("script"))
                          {            nextState=SCRIPT1;
                                       System.out.println("Mierda paso"+   nom_etiqueta + SCRIPT1);
                                       nom_etiqueta="";
                                       yypushback(yylength());
                                       yybegin(SCRIPT1);
                          }
                          else if(nom_etiqueta.equals("style"))
                          {            
                                       nom_etiqueta="";
                                       yypushback(yylength());
                                       yybegin(STYLE1);
                          }
                          else {                                 
                                  
                                     yypushback(yylength());
                                     yybegin(YYINITIAL);
                                 }
                                 
                        }                                
                         
    
}


<ESTADO7>{
     {NOM_ETIQUETAS}        {
                            string_tag.append( yytext());
                            lexeme=yytext();
                          
                            yybegin(ESTADO8);
                            return new Symbol (nombre_etiqueta,yycolumn, yyline, yytext());
                        }

    
    {RAIZ_HTML}     { 
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(html_r,yycolumn, yyline, yytext());
                        }
    {HEAD}     { 
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(html_h,yycolumn, yyline, yytext());
                        }
    {BODY}     { 
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(html_b,yycolumn, yyline, yytext());
                        }
    {STYLE}     { 
                   
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(style,yycolumn, yyline, yytext());
                        }
    {SCRIPT}     { 
                      
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(script,yycolumn, yyline, yytext());
                        }
    {TITLE}     { 
                      
                        lexeme=yytext();
                        yybegin(ESTADO2);
                        return new Symbol(etiqueta_title,yycolumn, yyline, yytext());
                        }

     [^]                {
                         string_tag.setLength(0);
                         yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                         yybegin(YYINITIAL);
                        }

}
<ESTADO8>{
    [>]                 {
                        string_tag.append( yytext());
                        lexeme=yytext();
                        yybegin(ETIQUETA_CIERRE);
                        return new Symbol(gt,yycolumn, yyline, yytext());
                        }

     [^]                {
                         string_tag.setLength(0);
                         yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                         yybegin(YYINITIAL);
                        }

}

<ETIQUETA_CIERRE>{

    .                  {
                        lexeme=string_tag.toString();
                        yybegin(YYINITIAL);
                        yypushback(yylength());
                        }
    


}

<STYLE1>{
    {WHITE}             {   yybegin(STYLE1);}

"."({L}|{D})+         {
                        lexeme=yytext();
                        yybegin(STYLE2);
                        return new Symbol(css_selector,yycolumn, yyline, yytext());
                        }
"#"({L}|{D})+         {
                        lexeme=yytext();
                        yybegin(STYLE2);
                        
                        return new Symbol(css_selector,yycolumn, yyline, yytext());
                        }
{NOM_ETIQUETAS}         {
                        lexeme=yytext();
                        yybegin(STYLE2);
                        return new Symbol(css_selector,yycolumn, yyline, yytext());
                        }

  [^]                {
                         
                         yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                         yybegin(YYINITIAL);
                        }

}


<STYLE2>{
   {WHITE}          {yybegin(STYLE2);}
  "{"               {
                        lexeme=yytext();
                        yybegin(STYLE3);
                       
                        return new Symbol(lbrace,yycolumn, yyline, yytext());
                        }

  [^]                {
                         
                         yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                         yybegin(YYINITIAL);
                        }


}

<STYLE3>
{

  {WHITE}          {yybegin(STYLE3);}
  {CSS_PROPIEDAD}   {
                        lexeme=yytext();
                        yybegin(STYLE3);
                        return new Symbol(css_propiedades,yycolumn, yyline, yytext());
                        }


    ":"                   {lexeme = yytext();  yybegin(STYLE3); return new Symbol(colon,yycolumn, yyline, yytext()); }

    ";"                   {lexeme = yytext(); yybegin(STYLE3); return new Symbol(semicolon,yycolumn, yyline, yytext()); }

    ({L}|{D})+               {
                        lexeme=yytext();
                        yybegin(STYLE3);
                        return new Symbol(css_valor_propiedad,yycolumn, yyline, yytext());
                        }


    "}"               {
                        lexeme=yytext();
                        yybegin(STYLE1);
                        return new Symbol(rbrace,yycolumn, yyline, yytext());
                        }   

                        



  [^]                {
                         
                         yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                         yybegin(YYINITIAL);
                        }

  
}


///////////////////////-------------
///////////////////////-----------
////////////////////////--------
/////////////////////-----------
///-------------------------
//ESTADOS DECLARACIONES

<DECLARACIONES1>
{


{DECLACRACION_VAR_JS}       {
                            lexeme=yytext();
                            yybegin(DECLARACIONES2);
                            return new Symbol(declaraciones,yycolumn, yyline, yytext());
                            }

[^]                         {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }

}

<DECLARACIONES2>
{
{WHITE}                     {yybegin(DECLARACIONES2);}

{L}+({L}|{D})*                           {
                            lexeme=yytext();
                            yybegin(DECLARACIONES2);
                            return new Symbol(id,yycolumn, yyline, yytext());
                            }
","                         {
                            lexeme=yytext();
                            yybegin(DECLARACIONES2);
                            return new Symbol(coma,yycolumn, yyline, yytext());
                            }
"="                         {
                            lexeme=yytext();
                            yybegin(DECLARACIONES3);
                            return new Symbol(eq,yycolumn, yyline, yytext());
                            }



[^]                         {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }
}

<DECLARACIONES3>
{
{WHITE}                     {yybegin(DECLARACIONES3);}

{D}+                         {
                            lexeme=yytext();
                            yybegin(DECLARACIONES3);
                            return new Symbol(digito,yycolumn, yyline, yytext());
                            }
"\"" ({WHITE}*|{ALFANUMERICO}+)"\""     {
                            lexeme=yytext();
                            yybegin(DECLARACIONES3);
                            return new Symbol(string,yycolumn, yyline, yytext());
                            }
{BOOLEAN}     {
                            lexeme=yytext();
                            yybegin(DECLARACIONES3);
                            return new Symbol(booleano,yycolumn, yyline, yytext());
                            }
";"                         {
                            lexeme=yytext();
                            yybegin(nextState);
                                
                            return new Symbol(semicolon,yycolumn, yyline, yytext());
                            }
","                         {
                            lexeme=yytext();
                            yybegin(DECLARACIONES2);
                            return new Symbol(coma,yycolumn, yyline, yytext());
                            }



[^]                         {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }
}




<DECLARACIONES4>
{
{WHITE}                     {yybegin(DECLARACIONES4);}

{L}+({L}|{D})*              {
                            lexeme=yytext();
                            yybegin(DECLARACIONES4);
                            return new Symbol(id,yycolumn, yyline, yytext());
                            }

"="                         {
                            lexeme=yytext();
                            yybegin(DECLARACIONES5);
                            return new Symbol(eq,yycolumn, yyline, yytext());
                            }



[^]                         {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }
}

<DECLARACIONES5>
{
{WHITE}                     {yybegin(DECLARACIONES5);}

{D}+                         {
                            lexeme=yytext();
                            yybegin(DECLARACIONES5);
                            return new Symbol(digito,yycolumn, yyline, yytext());
                            }
"\"" ({WHITE}*|{ALFANUMERICO}+)"\""     {
                            lexeme=yytext();
                            yybegin(DECLARACIONES5);
                            return new Symbol(string,yycolumn, yyline, yytext());
                            }
{BOOLEAN}     {
                            lexeme=yytext();
                            yybegin(DECLARACIONES5);
                            return new Symbol(booleano,yycolumn, yyline, yytext());
                            }
";"                         {
                            System.out.println("mierda que se ve en el camino" + nextState);
                            lexeme=yytext();
                            yybegin(nextState);
                            return new Symbol(semicolon,yycolumn, yyline, yytext());
                            }



[^]                         {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }
}


///////////////////////-------------
///////////////////////-----------
////////////////////////--------
/////////////////////-----------
///-------------------------
//ESTADOS CONTROL FLUJO

<CONTROL_FLUJO1>
{

{WHITE}                     {yybegin(CONTROL_FLUJO1);}

{IF}                        {               
                                            lexeme=yytext();
                                            yybegin(CONTROL_FLUJO2);
                                            return new Symbol(condicion_if,yycolumn, yyline, yytext());
                            }
{ELSE}                        {
                                            lexeme=yytext();
                                            yybegin(CONTROL_FLUJO2);
                                            return new Symbol(condicion_else,yycolumn, yyline, yytext());
                            }
{WHILE}                        {
                                            lexeme=yytext();
                                            yybegin(CONTROL_FLUJO2);
                                            return new Symbol(iteracion_while,yycolumn, yyline, yytext());
                            }

[^]                         {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }

}

<CONTROL_FLUJO2>
{

{WHITE}                     {yybegin(CONTROL_FLUJO2);}

"("                        {
                                            lexeme=yytext();
                                            yybegin(CONTROL_FLUJO3);
                                            return new Symbol(lparen,yycolumn, yyline, yytext());
                            }

[^]                         {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }

}
<CONTROL_FLUJO3>
{

{WHITE}                     {yybegin(CONTROL_FLUJO3);}

{L}+({L}|{D})*              {
                            lexeme=yytext();
                            yybegin(CONTROL_FLUJO3);
                            return new Symbol(id,yycolumn, yyline, yytext());
                            }
{D}              {
                            lexeme=yytext();
                            yybegin(CONTROL_FLUJO3);
                            return new Symbol(digito,yycolumn, yyline, yytext());
                            }


{CONDICION_JS}             {
                            lexeme=yytext();
                            yybegin(CONTROL_FLUJO4);
                            return new Symbol(condicion_js,yycolumn, yyline, yytext());
                            }

{BOOLEAN}                  {
                            lexeme=yytext();
                            yybegin(CONTROL_FLUJO3);
                            return new Symbol(booleano,yycolumn, yyline, yytext());
                            }

"\"" {ALFANUMERICO}+"\""    {
                            lexeme=yytext();
                            yybegin(CONTROL_FLUJO3);
                            return new Symbol(string,yycolumn, yyline, yytext());
                            }






[^]                         {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }

}
<CONTROL_FLUJO4>
{

{WHITE}                     {yybegin(CONTROL_FLUJO4);}

{L}+({L}|{D})*              {
                            lexeme=yytext();
                            yybegin(CONTROL_FLUJO4);
                            return new Symbol(id,yycolumn, yyline, yytext());
                            }


{D}              {
                            lexeme=yytext();
                            yybegin(CONTROL_FLUJO4);
                            return new Symbol(id,yycolumn, yyline, yytext());
                            }
"\"" {ALFANUMERICO}+"\""    {
                            lexeme=yytext();
                            yybegin(CONTROL_FLUJO4);
                            return new Symbol(string,yycolumn, yyline, yytext());
                            }
{BOOLEAN}                  {
                            lexeme=yytext();
                            yybegin(CONTROL_FLUJO4);
                            return new Symbol(booleano,yycolumn, yyline, yytext());
                            }

{CONDICION_JS}             {
                            lexeme=yytext();
                            yybegin(CONTROL_FLUJO3);
                            return new Symbol(condicion_js,yycolumn, yyline, yytext());
                            }
")"              {
                            lexeme=yytext();
                            yybegin(CONTROL_FLUJO5);
                            return new Symbol(lparen,yycolumn, yyline, yytext());
                            }



[^]                         {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }

}


<CONTROL_FLUJO5>
{   

{WHITE}                     {yybegin(CONTROL_FLUJO6);}

"{"                         {
                            lexeme=yytext();
                            yybegin(CONTROL_FLUJO6);
                            return new Symbol(lbrace,yycolumn, yyline, yytext());
                            }




[^]                         {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }

}

<CONTROL_FLUJO6>
{

 "console.log"                      {lexeme = yytext(); return new Symbol(console_log,yycolumn, yyline, yytext()); }
 "return"                       {lexeme = yytext(); return new Symbol(metodo_return,yycolumn, yyline, yytext()); }


{WHITE}                     {yybegin(CONTROL_FLUJO6);}



{FOR}                 {                  
                                
                                yypushback(yylength());
                                yybegin(FOR1);

                             }
{IF}|{ELSE} |{WHILE}                {                  
                             
                                yypushback(yylength());
                                yybegin(CONTROL_FLUJO1);

                             }



{DECLACRACION_VAR_JS}       {   
                           
                                yypushback(yylength());
                                yybegin(DECLARACIONES1);
                             }

{L}+({L}|{D})*              {
                                
                               
                                yypushback(yylength());
                                yybegin(DECLARACIONES4);
                            }
"}"                         {   
                                System.out.println("que pedo wey" +nextState);
                                yypushback(yylength());
                                yybegin(nextState);
                             }

[^]                         {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }


}
<CONTROL_FLUJO7>
{


{WHITE}                     {yybegin(CONTROL_FLUJO7);}



"}"                         {   
                                System.out.println("que pedo wey" +nextState);
                                yypushback(yylength());
                                yybegin(nextState);
                             }

[^]                         {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }


}
//////////////""""""""""""""""""""
//////////////""""""""""""""""""""""""""
//////////////"""""""""""""""""""""""
/////////////""""""""""""""""""""""""
////////////"""""""""""""""""""""

<FUNCION1>{

{WHITE}                     {yybegin(FUNCION1);}


{FUNCIONES_JS}                {   
                                yybegin(FUNCION2);
                                return new Symbol(funcion,yycolumn, yyline, yytext());
                            }


[^]                         {
                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }

}



<FUNCION2>{

{WHITE}                     {yybegin(FUNCION2);}


{L}+({L}|{D})*              {
                            lexeme=yytext();
                            yybegin(FUNCION2);
                            return new Symbol(nombre_funcion,yycolumn, yyline, yytext());
                            }


"("                         {
                            lexeme=yytext();
                            yybegin(FUNCION3);
                            return new Symbol(nombre_funcion,yycolumn, yyline, yytext());
                            }


[^]                         {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }

}


<FUNCION3>{
    {WHITE}                { yybegin(FUNCION3);}


    {L}+({L}|{D})*         {  
                            lexeme=yytext();
                            yybegin(FUNCION3);
                            return new Symbol(parametro,yycolumn, yyline, yytext());
                            }
   
   

  
    ","                     {  
                            lexeme=yytext();
                            yybegin(FUNCION3);
                            return new Symbol(coma,yycolumn, yyline, yytext());
                            }




    ")"                 {  
                            
                            lexeme=yytext();
                            yybegin(nextState);
                            System.out.println("Este es al estado que entro"+ nextState);
                            return new Symbol(rparen,yycolumn, yyline, yytext());
                            }
   

    

 
    [^]                     {

                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }

}



///////////////////////77
////////////////////////
///////////////////////
//////////////////
//////////////////////
///////////////////////
<FOR1>
{


{WHITE}                     {yybegin(FOR1);}


{FOR}                {         
                               
                                
                                lexeme=yytext();
                                yybegin(FOR1);
                                return new Symbol(iteracion_for,yycolumn, yyline, yytext());
                                

                      
                            }


[^]                         {
                             yypushback(yylength()); /*devuelve el lexema al estado inicial no perdiendo el dato*/
                             yybegin(YYINITIAL);
                            }

}




<SCRIPT1>

{

    "console.log"               {lexeme = yytext(); return new Symbol(console_log,yycolumn, yyline, yytext()); }
    "return"               {lexeme = yytext(); return new Symbol(metodo_return,yycolumn, yyline, yytext()); }

    {WHITE}                     {yybegin(SCRIPT1);}


    {FUNCIONES_JS}              {   

                                    nextState=SCRIPT1;
                                    System.out.println("paso");
                                    lexeme=yytext();
                                    yybegin(FUNCION2);
                                    return new Symbol(funcion,yycolumn, yyline, yytext());
                                 }

   

    {FOR}                           {  
                                    nextState=SCRIPT1;
                                    yypushback(yylength());
                                    yybegin(FOR1);
                                    
                                     }
                                 

    {DECLACRACION_VAR_JS}           {
                                    nextState=SCRIPT1;
                                    lexeme=yytext();
                                    yybegin(DECLARACIONES2);
                                    return new Symbol(declaraciones,yycolumn, yyline, yytext());
                                     }
    {IF}                              {  
                                         nextState=SCRIPT1;
                                        yypushback(yylength());
                                        yybegin(CONTROL_FLUJO1);
                                    
                                    
                                     }
    {ELSE}                           {   
                                     nextState=SCRIPT1;
                                    yypushback(yylength());
                                    yybegin(CONTROL_FLUJO1);
                                    
                                 }


    {WHILE}                           { 
                                     nextState=SCRIPT1;
                                    yypushback(yylength());
                                    yybegin(CONTROL_FLUJO1);
                                    
                                 }
     {L}+({L}|{D})*               {
                                 nextState=SCRIPT1;
                                 lexeme=yytext();
                                 yybegin(DECLARACIONES2);
                                 return new Symbol(id,yycolumn, yyline, yytext());
                                 }

    
   "{"                         {
                                nextState=SCRIPT1;
                                lexeme=yytext();
                                yybegin(CONTROL_FLUJO6);
                                return new Symbol(lbrace,yycolumn, yyline, yytext());
                             }
   "}"                         {
                                System.out.println("burrada");
                                nextState=SCRIPT1;
                                lexeme=yytext();
                                yybegin(SCRIPT1);
                                return new Symbol(rbrace,yycolumn, yyline, yytext());
                             }

  
 

[^]                            { 
                                    
                                    yypushback(yylength());
                                    yybegin(YYINITIAL);
                                    
                                 }

        






}


<COMENTARIO1>
{

    
    [^]*"-->"   {yybegin(YYINITIAL);}
    [^]         {yybegin(COMENTARIO1);}



}
























{WHITE} {/*Ignore*/}
/*[-] {/*Ignore*/}*/









/*PRODUCTO*/



"<!DOCTYPE html>" {lexeme=yytext();/* return DOC_HTML5;*/}
 /*[<]{1}[/]*({L}+({L}|{WHITE})*) ({WHITE}*|(["="]["\""]{L}+["\""]))[>] {lexeme=yytext(); return ETIQUETA;}*/
 /*[<]{1}[/]{0,1} {L}+ (""|({WHITE}{1}{L}+("=")(("\"")(""|{ALFANUMERICO})+("\""){WHITE}*))*) [>]{1} {lexeme=yytext(); return ETIQUETA;}*/

/*   [<]{1}[/]{0,1} {L}+ {ATRIBUTOS_HTML}[>]{1} {lexeme=yytext(); return ETIQUETA;}*/






 /*   {L}({D})* {lexeme=yytext(); return ID;}*/
 /*("(-"{D}+")")|{D}+ {lexeme= yytext();ArrayListMesas.add(Integer.parseInt(yytext())); return NUMERO_DE_MESA;}*/
/*( VAR|ID";")|(VAR|ID"="+";") {lexeme= yytext(); return VARIABLE;}*/
. {lexeme= yytext(); return new Symbol(error,yycolumn, yyline, yytext());}
<<EOF>>                          { return new Symbol(EOF,yycolumn, yyline, yytext()); }

