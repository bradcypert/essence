import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

import 'package:essence/src/node.dart';

class TreeParser {
  static parse(String text) {
    var document = parser.parseFragment(text);
    return TreeParser.convertNodes(document.children);
  }

  static List<Node> convertNodes(List<dom.Element> elements) {
    var nodes = elements.map((element) {
      return Node(
            type: element.localName,
            properties: element.attributes,
            children: convertNodes(element.children)
      );
    }).toList();

    return nodes;
  }
}
