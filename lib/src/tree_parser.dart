import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:universal_html/html.dart' as uhtml;

import 'package:essence/src/node.dart';

class TreeParser {
  static List<Node> parse(String text) {
    var document = parser.parseFragment(text);
    return TreeParser._convertNodes(document.children);
  }

  static List<Node> parseElement(uhtml.Element element) {
    var document = parser.parseFragment(element.outerHtml);
    return TreeParser._convertNodes(document.children);
  }

  static List<Node> _convertNodes(List<dom.Element> elements) {
    var nodes = elements.map((element) {
      return Node(
          type: element.localName,
          properties: element.attributes,
          children: _convertNodes(element.children));
    }).toList();

    return nodes;
  }
}
