import "package:test/test.dart";
import "package:essence/src/tree_diff.dart";
import "package:essence/src/node.dart";

void main() {
  group("TreeDiff", () {
    test("Two empty node lists should return an empty list of actions", () {
     expect(TreeDiff.diff([], []), equals([]));
    });

    test("A list of a single node should return an insertion action", () {
      var node = Node(type: "a");
      var actions = TreeDiff.diff([], [node]);
      expect(actions[0].node, equals(node));
      expect(actions[0] is NodeInsertion, equals(true));
    });

    test("A list of a single node in the base but none in the target should return a deletion action", () {
      var node = Node(type: "a");
      var actions = TreeDiff.diff([node], []);
      expect(actions[0].node, equals(node));
      expect(actions[0] is NodeDeletion, equals(true));
    });

    test("A list of two single different nodes between base and target should return a delete for the base node and an update for the target node", () {
      var node1 = Node(type: "a");
      var node2 = Node(type: "b");
      var actions = TreeDiff.diff([node1], [node2]);
      expect(actions[0].node, equals(node1));
      expect(actions[0] is NodeDeletion, equals(true));
      expect(actions[1].node, equals(node2));
      expect(actions[1] is NodeInsertion, equals(true));
    });

    test("Same nodes should not generate actions", () {
      var node1 = Node(type: "a");
      var node2 = Node(type: "a");
      var actions = TreeDiff.diff([node1], [node2]);
      expect(actions.length, equals(0));
    });
  });
}
