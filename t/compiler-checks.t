#!inc/bin/testml-cpan


*grammar.bootstrap-compile.yaml.clean == *yaml
  :"+ (bootstrap compile)"

*grammar.compile.yaml.clean == *yaml
  :"+ (pegex compile)"


=== Empty Grammar
--- grammar
--- yaml
{}


=== Whitespace Tokens
--- grammar
a: - b+ + c -
b: /- 'cat' + 'dog' -/
--- yaml
a:
  .all:
  - .ref: _
  - +min: 1
    .ref: b
  - .ref: __
  - .ref: c
  - .ref: _
b:
  .rgx: <_>cat<__>dog<_>


=== Simple Grammar
--- grammar
a: ( b c* )+
b: /x/
c: x
--- yaml
a:
  +min: 1
  .all:
  - .ref: b
  - +min: 0
    .ref: c
b:
  .rgx: x
c:
  .ref: x


=== Dash in Rule Names
--- grammar
a-b: c-d
--- yaml
a_b:
  .ref: c_d


=== Single Rule Reference
--- grammar
a: x
--- yaml
a:
  .ref: x


=== Single Rule brackets
--- grammar
a: <x>
--- ^yaml


=== All Rules
--- grammar
a: x y z
--- yaml
a:
  .all:
  - .ref: x
  - .ref: y
  - .ref: z


=== Any Rules
--- grammar
a: x | y | z
--- yaml
a:
  .any:
  - .ref: x
  - .ref: y
  - .ref: z


=== Any Rules with Leading Pipe
--- grammar
a: | x | y | z
--- yaml
a:
  .any:
  - .ref: x
  - .ref: y
  - .ref: z


=== Separator Syntax
--- grammar
a: b+ % c | d* %% e
--- yaml
a:
  .any:
  - .all:
    - .ref: b
    - +min: 0
      -flat: 1
      .all:
      - .ref: c
      - .ref: b
  - +max: 1
    .all:
    - .ref: d
    - +min: 0
      -flat: 1
      .all:
      - .ref: e
      - .ref: d
    - +max: 1
      .ref: e


=== Complex All/Any Precedence
--- grammar
a: b c | ( d | e | f* % g h ) i
--- yaml
a:
  .any:
  - .all:
    - .ref: b
    - .ref: c
  - .all:
    - .any:
      - .ref: d
      - .ref: e
      - .all:
        - +max: 1
          .all:
          - .ref: f
          - +min: 0
            -flat: 1
            .all:
            - .ref: g
            - .ref: f
        - .ref: h
    - .ref: i


=== Single Rule With Trailing Quantifier
--- grammar
a: x*
--- yaml
a:
  +min: 0
  .ref: x


=== Single Rule With Trailing Quantifier (no angles)
--- grammar
a: x*
--- ^yaml


=== Single Rule With Leading Assertion
--- grammar
a: =x
--- yaml
a:
  +asr: 1
  .ref: x


=== Negative and Positive Assertion
--- grammar
a: !b =c
--- yaml
a:
  .all:
  - +asr: -1
    .ref: b
  - +asr: 1
    .ref: c


=== Single Regex
--- grammar
a: /x/
--- yaml
a:
  .rgx: x


=== Quoted Regex
--- grammar
a: '*** <foo>  + - bar '
--- yaml
a:
  .rgx: '\*\*\*\ <foo\>\ \ \+\ \-\ bar\ '


=== Quoted String in Regex
--- grammar
a: /('(foo*)')*/
--- yaml
a:
  .rgx: (\(foo\*\))*


=== Single Error
--- grammar
a: `x`
--- yaml
a:
  .err: x


=== Skip and Wrap Marker
--- grammar
a: .b +c+ -d?
--- yaml
a:
  .all:
  - -skip: 1
    .ref: b
  - +min: 1
    -wrap: 1
    .ref: c
  - +max: 1
    -flat: 1
    .ref: d


=== Unbracketed All Group
--- grammar
a: /x/ y
--- yaml
a:
  .all:
  - .rgx: x
  - .ref: y


=== Unbracketed Any Group
--- grammar
a: /x/ | y | `z`
--- yaml
a:
  .any:
  - .rgx: x
  - .ref: y
  - .err: z


=== Any Group with Leading Pipe
--- grammar
a: (
  | b
  | c
)
--- yaml
a:
  .any:
  - .ref: b
  - .ref: c


=== Bracketed All Group
--- grammar
a: ( x y )
--- yaml
a:
  .all:
  - .ref: x
  - .ref: y


=== Bracketed Group With Trailing Modifier
--- grammar
a: ( x y )?
--- yaml
a:
  +max: 1
  .all:
  - .ref: x
  - .ref: y


=== Bracketed Group With Leading Modifier
--- grammar
a: .( =x y )
--- yaml
a:
  -skip: 1
  .all:
  - +asr: 1
    .ref: x
  - .ref: y


=== Multiple Groups
--- grammar
a: ( x y ) ( z | /zzz/ )
--- yaml
a:
  .all:
  - .all:
    - .ref: x
    - .ref: y
  - .any:
    - .ref: z
    - .rgx: zzz


=== List Separator
--- grammar
a: b | c+ %% /d/
--- yaml
a:
  .any:
  - .ref: b
  - .all:
    - .ref: c
    - +min: 0
      -flat: 1
      .all:
      - .rgx: d
      - .ref: c
    - +max: 1
      .rgx: d


=== Separators with Quantifiers
--- grammar
a: <b>2+ % c* d* %% <e>2-3
--- yaml
a:
  .all:
  - .all:
    - .ref: b
    - +min: 1
      -flat: 1
      .all:
      - +min: 0
        .ref: c
      - .ref: b
  - +max: 1
    .all:
    - .ref: d
    - +min: 0
      -flat: 1
      .all:
      - +max: 3
        +min: 2
        .ref: e
      - .ref: d
    - +max: 1
      +min: 2
      .ref: e


=== All Quantifier Forms
--- grammar
a: b c? d* e+ <f>55 <g>5+ <h>5-55
--- yaml
a:
  .all:
  - .ref: b
  - +max: 1
    .ref: c
  - +min: 0
    .ref: d
  - +min: 1
    .ref: e
  - +max: 55
    +min: 55
    .ref: f
  - +min: 5
    .ref: g
  - +max: 55
    +min: 5
    .ref: h


=== Whitespace Tokens
--- grammar
a: - b+ + c -
b: /- cat + dog -/
c: /+/
d: /+ kitty/
--- yaml
a:
  .all:
  - .ref: _
  - +min: 1
    .ref: b
  - .ref: __
  - .ref: c
  - .ref: _
b:
  .rgx: <_><cat><__><dog><_>
c:
  .rgx: <__>
d:
  .rgx: <__><kitty>


=== Whitespace in Regex
--- grammar
a: /<DOT>* (<DASH>{3})
    <BANG>   <BANG>
   /
--- yaml
a:
  .rgx: <DOT>*(<DASH>{3})<BANG><BANG>


# Drop support for --
=== Dash and Plus as whitespace tokens
--- grammar
a: / - foo + bar+ -- baz /
--- yaml
a:
  .rgx: <_><foo><__><bar>+<__><baz>


=== Directives
--- grammar
%grammar foo
%version 1.2.3
--- yaml
+grammar: foo
+version: 1.2.3


=== Multiple Duplicate Directives
--- grammar
%grammar foo
%include bar
%include baz
--- yaml
+grammar: foo
+include:
- bar
- baz


=== Meta Lines
--- grammar
%grammar        foo
%version    1.1.1
%extends bar bar  
%include   bazzy 
a: /b/
--- yaml
+extends: bar bar
+grammar: foo
+include: bazzy
+version: 1.1.1
a:
  .rgx: b


=== Dash and Plus as whitespace tokens
--- grammar
a: / - foo + bar+ -- baz /
--- yaml
a:
  .rgx: <_><foo><__><bar>+<__><baz>
