import 'package:essence/src/node.dart';

/// Define actions to be processed against a tree.
class NodeAction {
  String selector;
  Node node;
}

class NodeInsertion implements NodeAction {
  @override
  String selector;
  @override
  Node node;

  NodeInsertion({this.node, this.selector});
}

class NodeDeletion implements NodeAction {
  @override
  String selector;
  @override
  Node node;

  NodeDeletion({this.node, this.selector});
}

class TreeDiff {
  /// Diff two node lists, returning a list of NodeActions
  static List<NodeAction> diff(
      List<Node> baseNodeList, List<Node> targetNodeList,
      {currentSelector = ''}) {
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
          node: e.value, selector: _createSelector(currentSelector, e.key))));
    }

    var matchingIndexes = targetEntriesList
        .where((entry) => entry.value == baseEntries[entry.key]);
    var nonMatchingIndexesForTarget = targetEntriesList
        .where((entry) => entry.value != baseEntries[entry.key]);
    var nonMatchingIndexesForBase = baseEntriesList
        .where((entry) => entry.value != targetEntries[entry.key]);

    actions.addAll(nonMatchingIndexesForBase.map((e) => NodeDeletion(
        node: e.value, selector: _createSelector(currentSelector, e.key))));
    actions.addAll(nonMatchingIndexesForTarget.map((e) => NodeInsertion(
        node: e.value, selector: _createSelector(currentSelector, e.key))));

    // process child nodes of matching
    if (matchingIndexes.isNotEmpty) {
      actions.addAll(matchingIndexes
          .map((e) => TreeDiff.diff(
              baseEntries[e.key].children ?? [], e.value.children ?? [],
              currentSelector: _createSelector(currentSelector, e.key)))
          .expand((e) => e));
    }

    return actions;
  }

  static String _createSelector(currentSelector, index) {
    return '${currentSelector != "" ? currentSelector + " >" : ""} *:nth-of-type(${index})'
        .trim();
  }
}
