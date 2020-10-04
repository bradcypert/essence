import 'dart:collection';

/// Represents a virtual DOM node
///
/// This class captures the minimal pieces of data that
/// an object needs to be considered a Node by essence.
class Node {
  String type;
  LinkedHashMap<dynamic, String> properties;
  List<Node> children;

  Node({this.type, this.properties, this.children});

  /// Equality is overriden here to help us create a robust way of comparing nodes.
  @override
  bool operator ==(node) {
    return node is Node &&
        node.type ==
            type; // TODO: Add properties and children to this comparison
  }
}
