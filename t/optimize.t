#!inc/bin/testml-cpan

1 == 1
  :"[SKIP] Skipping this test for now. Might need a %Skip in TestML."

# *grammar.compile.optimize.yaml.clean == *yaml


=== Question Mark Expansion
--- SKIP
--- grammar
a: /(:foo)/
--- yaml
a:
  .rgx: /(?:foo)/
