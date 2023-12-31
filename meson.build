project('vala-tree-sitter', 'vala', 'c')

tree_sitter_sources = ['vendor/tree-sitter/src/runtime/runtime.c',
  'fixtures/tree-sitter-typescript/src/scanner.c',
  'fixtures/tree-sitter-typescript/src/parser.c',
  'fixtures/tree-sitter-scala/src/scanner.c',
  'fixtures/tree-sitter-scala/src/parser.c',
  'fixtures/tree-sitter-json/src/parser.c',
  'fixtures/tree-sitter-css/src/scanner.c',
  'fixtures/tree-sitter-css/src/parser.c',
  'fixtures/tree-sitter-go/src/parser.c',
  'fixtures/tree-sitter-c/src/parser.c',
  'fixtures/tree-sitter-java/src/parser.c',
  'fixtures/tree-sitter-javascript/src/scanner.c',
  'fixtures/tree-sitter-javascript/src/parser.c',
  'fixtures/tree-sitter-rust/src/scanner.c',
  'fixtures/tree-sitter-rust/src/parser.c']

tree_sitter_lib = static_library('tree-sitter-runtime', tree_sitter_sources, 
  include_directories: [
    include_directories('vendor/tree-sitter/src'), 
    include_directories('vendor/tree-sitter/include'),
    include_directories('vendor/tree-sitter/externals/utf8proc')
  ]
)

tree_sitter_vapi = meson.get_compiler('vala').find_library('libtreesitter', dirs: join_paths(meson.source_root(), 'vapi'))

tree_sitter_dep = declare_dependency(
	link_with: tree_sitter_lib,
	include_directories: include_directories(join_paths('vendor', 'tree-sitter', 'include')),
	dependencies: tree_sitter_vapi,
)

subdir('src')

