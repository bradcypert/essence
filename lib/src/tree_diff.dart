import "package:essence/src/node.dart";


/// Define actions to be processed against a tree.
class NodeAction {
  String XPATH;
  Node node;
}

class NodeInsertion implements NodeAction {
  String XPATH;
  Node node;

  NodeInsertion({this.node, this.XPATH});
}

class NodeDeletion implements NodeAction {
  String XPATH;
  Node node;

  NodeDeletion({this.node, this.XPATH});
}

class TreeDiff {
  /// Diff two node lists, returning a list of NodeActions
  static List<NodeAction> diff(List<Node> baseNodeList, List<Node> targetNodeList, [List<NodeAction> nodeActions, currentXPATH = ""]) {
    List<NodeAction> actions = nodeActions != null ? List.from(nodeActions) : [];
    if (baseNodeList.isEmpty && targetNodeList.isEmpty) {
      return actions;
    }

    // Items that are only in the base will generate deletion actions
    var onlyInBase = List.from(baseNodeList)..removeWhere((node) => targetNodeList.contains(node));
    // Items that are only in the target will generate insertion actions
    var onlyInTarget = List.from(targetNodeList)..removeWhere((node) => baseNodeList.contains(node));
    // Items thare are in both need further inspection but should ultimately generate deletion and insertion actions
    var onlyInBoth = List.from(targetNodeList)..removeWhere((node) => !baseNodeList.contains(node));

    onlyInBase.forEach((node) {
      actions.add(NodeDeletion(node: node, XPATH: currentXPATH));
    });

    
    onlyInTarget.forEach((node) {
      actions.add(NodeInsertion(node: node, XPATH: currentXPATH));
    });

    return actions;
  }
}
