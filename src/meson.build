tree_sitter_vapi = meson.get_compiler('vala').find_library('libtreesitter', dirs: join_paths(meson.source_root(), 'vapi'))

executable('tree-walker', 'main.vala', link_with: tree_sitter_lib, dependencies: [dependency('glib-2.0'), tree_sitter_vapi])
