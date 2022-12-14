#!inc/bin/testml-cpan


parse-to-tree(*grammar, *input).yaml.clean == *tree
  :"+ - Pegex::Tree"

parse-to-tree-wrap(*grammar, *input).yaml.clean == *wrap
  :"+ - Pegex::Tree::Wrap"

parse-to-tree-test(*grammar, *input).yaml.clean == *ast
  :"+ - TestAST"


=== Part of Pegex Grammar
--- grammar(#)
# This is the Pegex grammar for Pegex grammars!
grammar: ( <comment>* <rule_definition> )+ <comment>*
rule_definition: /<WS>*/ <rule_name> /<COLON><WS>*/ <rule_line>
rule_name: /(<ALPHA><WORD>*)/
comment: /<HASH><line><EOL>/
line: /<ANY>*/
rule_line: /(<line>)<EOL>/

--- input(#)
# This is the Pegex grammar for Pegex grammars!
grammar: ( <comment>* <rule_definition> )+ <comment>*
rule_definition: /<WS>*/ <rule_name> /<COLON><WS>*/ <rule_line>
--- tree
- - - []
    - - grammar
      - ( <comment>* <rule_definition> )+ <comment>*
  - - []
    - - rule_definition
      - /<WS>*/ <rule_name> /<COLON><WS>*/ <rule_line>
- []

--- wrap
grammar:
- - - []
    - rule_definition:
      - rule_name: grammar
      - rule_line: ( <comment>* <rule_definition> )+ <comment>*
  - - []
    - rule_definition:
      - rule_name: rule_definition
      - rule_line: /<WS>*/ <rule_name> /<COLON><WS>*/ <rule_line>
- []

