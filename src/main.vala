[CCode (cname = "tree_sitter_json")]
extern unowned TreeSitter.Language? get_language_json ();
[CCode (cname = "tree_sitter_c")]
extern unowned TreeSitter.Language? get_language_c ();

void main(string[] args) {
  var source_code = "[1, null]";
  if (args.length > 1)
    source_code = args[1];
  print("source: %s\n", source_code);

  var parser = new TreeSitter.Parser();
  var language_name="json";
  if (args.length > 2)
    language_name = args[2];
  print("language: %s\n", language_name);

  unowned TreeSitter.Language language = get_language_json();
  if (language_name == "c") {
    language = get_language_c();
  } else if (language_name == "json") {
    language = get_language_json();
  }
  parser.set_language(language);
  var version = language.get_version();
  print("language version: %"+uint32.FORMAT+"\n", version);
  var tree = parser.parse_string(null, source_code.data);
  var root_node = tree.root_node();
  print("AST: %s\n", root_node.to_str());
}
