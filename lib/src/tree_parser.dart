import 'package:html/parser.dart' as parser;

class TreeParser {
  parse(String text) {
    var document = parser.parseFragment(text);
    return document.nodes;
  }
}
