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
  });
}
