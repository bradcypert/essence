import 'package:test/test.dart';
import 'package:essence/src/tree_parser.dart';

void main() {
  group('TreeParser', () {
    test('parses a simple dom string into an element list', () {
      expect(TreeParser.parse('<div></div>').length, equals(1));
    });

    test('parses a complex dom string into an element list', () {
      expect(
          TreeParser.parse('<div class="container"><p>Text</p></div>').length,
          equals(1));
    });

    test('parses multiple elements at the root', () {
      expect(TreeParser.parse('<div></div><div></div>').length, equals(2));
    });

    test('Expect node children to be parsed properly', () {
      var tree = TreeParser.parse('<a><b></b></a>');
      expect(tree[0].type, equals('a'));
      expect(tree[0].children[0].type, equals('b'));
    });

    test('handles non-standard elements', () {
      var tree = TreeParser.parse('<FOO/>');
      expect(tree[0].type, equals('foo'));
    });

    test('should pull attributes from the node', () {
      var tree = TreeParser.parse('<ele isTest=true />');
      expect(tree[0].type, equals('ele'));
      expect(tree[0].properties, equals({'istest': 'true'}));
    });
  });
}
