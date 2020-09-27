import "package:test/test.dart";
import "package:essence/src/tree_diff.dart";
import "package:essence/src/node.dart";

void main() {
  group("TreeDiff", () {
    test("Two empty node lists should return an empty list of actions", () {
     expect(TreeDiff.diff([], []), equals([]));
    });
  });
}
