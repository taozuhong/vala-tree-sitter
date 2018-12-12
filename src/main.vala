
[CCode (cname = "tree_sitter_rust")]
extern unowned TreeSitter.Language? get_language_rust ();
[CCode (cname = "tree_sitter_c")]
extern unowned TreeSitter.Language? get_language_c ();
[CCode (cname = "tree_sitter_java")]
extern unowned TreeSitter.Language? get_language_java ();
[CCode (cname = "tree_sitter_javascript")]
extern unowned TreeSitter.Language? get_language_javascript ();
[CCode (cname = "tree_sitter_python")]
extern unowned TreeSitter.Language? get_language_python ();
[CCode (cname = "tree_sitter_ruby")]
extern unowned TreeSitter.Language? get_language_ruby ();
[CCode (cname = "tree_sitter_haskell")]
extern unowned TreeSitter.Language? get_language_haskell ();
[CCode (cname = "tree_sitter_cpp")]
extern unowned TreeSitter.Language? get_language_cpp ();
[CCode (cname = "tree_sitter_go")]
extern unowned TreeSitter.Language? get_language_go ();
[CCode (cname = "tree_sitter_bash")]
extern unowned TreeSitter.Language? get_language_bash ();
[CCode (cname = "tree_sitter_css")]
extern unowned TreeSitter.Language? get_language_css ();
[CCode (cname = "tree_sitter_json")]
extern unowned TreeSitter.Language? get_language_json ();
[CCode (cname = "tree_sitter_php")]
extern unowned TreeSitter.Language? get_language_php ();
[CCode (cname = "tree_sitter_html")]
extern unowned TreeSitter.Language? get_language_html ();

int main(string[] args) {
  var source_code = "[1, null]";
  if (args.length > 1)
    source_code = args[1];
  print("source: %s\n", source_code);

  var parser = new TreeSitter.Parser();
  var language_name="json";
  if (args.length > 2)
    language_name = args[2];

  unowned TreeSitter.Language language = get_language_json();
  if (language_name == "c") {
    language = get_language_c();
  } else if (language_name == "json") {
    language = get_language_json();
  } else if (language_name == "rust") {
    language = get_language_rust ();
//  } else if (language_name == "java") {
//    language = get_language_java (); }
  } else if (language_name == "javascript") {
    language = get_language_javascript ();
//  } else if (language_name == "python") {
//    language = get_language_python ();
//  } else if (language_name == "ruby") {
//    language = get_language_ruby ();
//  } else if (language_name == "haskell") {
//    language = get_language_haskell ();
//  } else if (language_name == "cpp") {
//    language = get_language_cpp ();
  } else if (language_name == "go") {
    language = get_language_go ();
//  } else if (language_name == "bash") {
//    language = get_language_bash ();
  } else if (language_name == "css") {
    language = get_language_css ();
//  } else if (language_name == "php") {
//    language = get_language_php ();
//  } else if (language_name == "html") {
//    language = get_language_html ();
  } else {
     print("Unknow %s language\n", language_name);
     return 1;
  }
  print("language: %s\n", language_name);

  parser.set_language(language);
  var tree = parser.parse_string(null, source_code.data);
  var root_node = tree.root_node();
  print("AST: %s\n", root_node.to_str());

  var indent = 0;
  print_node(ref root_node, ref source_code, indent);
  TreeSitter.TreeCursor tree_cursor = new TreeSitter.TreeCursor(root_node);
  var level = 0;
  var child_printed = false;
  while (true) {
    if (!child_printed && tree_cursor.goto_first_child()) {
      indent +=1;
      level += 1;
      var node = tree_cursor.current_node();
      print_node(ref node, ref source_code, indent);
    } else if (tree_cursor.goto_next_sibling()) {
      child_printed = false;
      var node = tree_cursor.current_node();
      print_node(ref node, ref source_code, indent);
      if (tree_cursor.goto_first_child()) {
        indent +=1;
        level += 1;
        node = tree_cursor.current_node();
        print_node(ref node, ref source_code, indent);
      }
    } else {
        if (level > 0) {
          tree_cursor.goto_parent();
          var node = tree_cursor.current_node();
          print("goto parent\n");
          print_node(ref node, ref source_code, indent);
          child_printed = true;
          level -= 1;
          indent -=1;
        } else {
          break;
        }
    }
  }
  return 0;
}

void print_node(ref TreeSitter.Node node, ref string source_code, int indent) {
  var separator_unit = "  ";
  string separator = "  ";
  for (int i = 0; i < indent; i++) {
    separator += separator_unit;
  }

  print("%s- node: %s\n", separator, node.to_str());
  print("%s  type: %s\n", separator, node.type());
  print("%s  start: %d, %d\n", separator, (int)node.start_point().row, (int)node.start_point().column);
  print("%s  end: %d, %d\n", separator, (int)node.end_point().row, (int)node.end_point().column);
  var chunk = source_code.substring(node.start_byte(), node.end_byte() - node.start_byte());
  print("%s  content: %s\n", separator, chunk);
}
