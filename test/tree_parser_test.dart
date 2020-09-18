import "package:test/test.dart";
import "package:essence/src/tree_parser.dart";

void main() {
  group("TreeParser", () {
    test("parses a simple dom string into an element list", () {
     expect(TreeParser().parse("<div></div>").length, equals(1));
    });

    test("parses a complex dom string into an element list", () {
      expect(TreeParser().parse('<div class="container"><p>Text</p></div>').length, equals(1));
    });

    test("parses multiple elements at the root", () {
      expect(TreeParser().parse('<div></div><div></div>').length, equals(2));
    });
  });
}
