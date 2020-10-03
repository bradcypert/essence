import 'package:essence/src/node.dart';

/// Define actions to be processed against a tree.
class NodeAction {
  String XPATH;
  Node node;
}

class NodeInsertion implements NodeAction {
  @override
  String XPATH;
  @override
  Node node;

  NodeInsertion({this.node, this.XPATH});
}

class NodeDeletion implements NodeAction {
  @override
  String XPATH;
  @override
  Node node;

  NodeDeletion({this.node, this.XPATH});
}

class TreeDiff {
  /// Diff two node lists, returning a list of NodeActions
  static List<NodeAction> diff(
      List<Node> baseNodeList, List<Node> targetNodeList,
      {currentXPATH = ''}) {
    // ignore: omit_local_variable_types
    List<NodeAction> actions = [];
    if (baseNodeList.isEmpty && targetNodeList.isEmpty) {
      return actions;
    }

    var baseEntries = List.from(baseNodeList).asMap();
    var targetEntries = List.from(targetNodeList).asMap();
    var baseEntriesList = baseEntries.entries.toList();
    var targetEntriesList = targetEntries.entries.toList();

    if (targetEntries.isEmpty) {
      actions.addAll(baseEntries.entries.map((e) => NodeDeletion(
          node: e.value, XPATH: '${currentXPATH}/*[${e.key + 1}]')));
    }

    var matchingIndexes = targetEntriesList
        .where((entry) => entry.value == baseEntries[entry.key]);
    var nonMatchingIndexesForTarget = targetEntriesList
        .where((entry) => entry.value != baseEntries[entry.key]);
    var nonMatchingIndexesForBase = baseEntriesList
        .where((entry) => entry.value != targetEntries[entry.key]);

    actions.addAll(nonMatchingIndexesForBase.map((e) =>
        NodeDeletion(node: e.value, XPATH: '${currentXPATH}/*[${e.key + 1}]')));
    actions.addAll(nonMatchingIndexesForTarget.map((e) => NodeInsertion(
        node: e.value, XPATH: '${currentXPATH}/*[${e.key + 1}]')));

    // process child nodes of matching
    if (matchingIndexes.isNotEmpty) {
      actions.addAll(matchingIndexes
          .map((e) => TreeDiff.diff(
              baseEntries[e.key].children ?? [], e.value.children ?? [],
              currentXPATH: '${currentXPATH}/*[${e.key + 1}]'))
          .expand((e) => e));
    }

    return actions;
  }
}
