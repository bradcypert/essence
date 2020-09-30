import 'dart:collection';

class Node {
  String type;
  LinkedHashMap<dynamic, String> properties;
  List<Node> children;

  Node({this.type, this.properties, this.children});

  @override
  bool operator ==(node) {
    return node is Node &&
        node.type ==
            type; // TODO: Add properties and children to this comparison
  }
}
