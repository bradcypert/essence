import "package:essence/src/node.dart";


/// Define actions to be processed against a tree.
class NodeAction {
  String XPATH;
  Node node;
}

class NodeInsertion extends NodeAction {}
class NodeDeletion extends NodeAction {}

class TreeDiff {
  /// Diff two node lists, returning a list of NodeActions
  static List<NodeAction> diff(nodeList1, nodeList2) {
    if (nodeList1.isEmpty && nodeList2.isEmpty) {
      return [];
    }
  }
}
