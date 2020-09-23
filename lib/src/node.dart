import 'dart:collection';

class Node {
  String type;
  LinkedHashMap<dynamic, String> properties;
  List<Node> children;

  Node({this.type, this.properties, this.children});
}
