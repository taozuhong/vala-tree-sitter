# Vala binding for Tree-sitter

Using AST parser in vala

## Building

```
git submodule update --recursive --init
meson build
ninja -C build
```

## Running

- Parse json:
```
./run.sh '{"a": "b"}' json 
source: {"a": "b"}
language: json
language version: 9
AST: (value (object (pair (string) (string))))
```

- Parse C:
```
./run.sh 'int main(char* argv, int argc) { print("hello world!");}' c
source: int main(char* argv, int argc) { print("hello world!");}
language: c
language version: 9
AST: (translation_unit (function_definition (primitive_type) (function_declarator (identifier) (parameter_list (parameter_declaration (primitive_type) (pointer_declarator (identifier))) (parameter_declaration (primitive_type) (identifier)))) (compound_statement (expression_statement (call_expression (identifier) (argument_list (string_literal)))))))
```

## credits

- Tree-sitter: http://tree-sitter.github.io/tree-sitter/
- Vala: https://wiki.gnome.org/Projects/Vala
