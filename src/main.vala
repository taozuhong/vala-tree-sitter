
void main(string[] args) {
  print("loaded c language\n");
  var parser = new TreeSitter.Parser();
  parser.set_language(TreeSitter.get_language_json());
  //var version = language.get_version();
  //print("version: %"+uint32.FORMAT+"\n", version);
  var source_code = "[1, null]";
  var tree = parser.parse_string(null, source_code, source_code.length);
  var root_node = tree.root_node();
  //print("%s\n", TreeSitter.type(root_node));
  print("%s\n", root_node.type());
  var input = 0;
  if (args.length > 1)
    input = int.parse(args[1]);
  print("%d\n", input);
}
