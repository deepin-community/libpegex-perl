#!inc/bin/testml-cpan


*grammar.compile.yaml == *grammar.bootstrap-compile.yaml
  :"Compiler output matches bootstrap? - +"


=== Single Regex
--- grammar
a: /x/


=== Single Reference
--- grammar
a: <b>


=== Single Error
--- grammar
a: `b`


=== Simple All Group
--- grammar
a: /b/ <c>


=== Simple Any Group
--- grammar
a: <b> | <c>


=== Bracketed All Group
--- grammar
a: ( <b> /c/ )


=== Bracketed Any Group
--- grammar
a: ( <b> | /c/ | `d` )


=== Bracketed Group in Unbracketed Group
--- grammar
a: <b> ( <c> | <d> )


=== And over Or Precedence
--- SKIP
--- grammar
a: <b> <c> | <d> <e> | <f> % <g>


=== Multiple Rules
--- grammar
a: <b>
b: <c>


=== Simple Grammar
--- grammar
a: ( <b> <c>* )
b: /x/
c: /y+/


=== Semicolons OK
--- grammar
a: <b>;
b: <c>
c: /d/;


=== Unbracketed
--- grammar
a: <b> <c> <d>
b: <c> | <d>


=== Not Rule
--- grammar
a: !<b> <c>


=== Multiline
--- grammar
a: <b>
   <c>
b:
    /c/ <d>
    <e>;
c:
    <d> |
    ( /e/ <f> )
    | `g`


=== Various Groups
--- grammar
a: <b> ( <c> | <d> )
b: ( <c> | <d> ) <e>
c: <d> | ( <e> <f>) | <g>
d: <e> | (<f> <g>) | <h> | ( `i` )
e: ( <f> )


=== Modifiers
--- grammar
a: !<a> =<b>
b: ( /c/ <d> )+
c: ( /c/ <d> )+


=== Any Group Plus Rule
--- grammar
a: /w/ ( <x>+ | <y>* ) <z>?


=== Equivalent
--- grammar
a: <b>
c: !<d>


=== Regex and Rule
--- grammar
a_b: /c/ <d>


=== Quantified group
--- grammar
a: <b> ( <c>* | <d>+ )+
e: ( <f> !<g> )?


=== Multiple Regex
--- grammar
b: ( /x/ )+


# XXX The \\# looks lie a testml bug. Should only need \#.
=== Comments
--- grammar(#)
# line comment

a: b    # end of line comment

b: /

    foo  # regex comment

    # regex line comment

    bar

    # regex line comment

/


=== Comment between rules
--- grammar(#)
a: b
# comment
b: c
