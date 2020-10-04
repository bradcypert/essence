import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:universal_html/html.dart' as uhtml;

import 'package:essence/src/node.dart';

/// Defines ways to parse common HTML structures into Essence Nodes.
class TreeParser {
  /// Parses textual HTML into essence nodes
  static List<Node> parse(String text) {
    var document = parser.parseFragment(text);
    return TreeParser._convertNodes(document.children);
  }

  /// Parses dart:html nodes into essence nodes
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
