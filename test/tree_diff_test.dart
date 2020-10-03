import 'package:test/test.dart';
import 'package:essence/src/tree_diff.dart';
import 'package:essence/src/node.dart';

void main() {
  group('TreeDiff', () {
    test('Two empty node lists should return an empty list of actions', () {
      expect(TreeDiff.diff([], []), equals([]));
    });

    test('A list of a single node should return an insertion action', () {
      var node = Node(type: 'a');
      var actions = TreeDiff.diff([], [node]);
      expect(actions[0].node, equals(node));
      expect(actions[0].XPATH, equals('/*[1]'));
      expect(actions[0] is NodeInsertion, equals(true));
    });

    test(
        'A list of a single node in the base but none in the target should return a deletion action',
        () {
      var node = Node(type: 'a');
      var actions = TreeDiff.diff([node], []);
      expect(actions[0].node, equals(node));
      expect(actions[0].XPATH, equals('/*[1]'));
      expect(actions[0] is NodeDeletion, equals(true));
    });

    test(
        'A list of a multiple nodes in the base but one matching in the target should return a deletion action',
        () {
      var node = Node(type: 'a');
      var node2 = Node(type: 'b');
      var actions = TreeDiff.diff([node2, node], [node]);
      expect(actions[0].node, equals(node2));
      expect(actions[0].XPATH, equals('/*[1]'));
      expect(actions[0] is NodeDeletion, equals(true));
    });

    test('Remove right node from base', () {
      var node = Node(type: 'a');
      var node2 = Node(type: 'b');
      var actions = TreeDiff.diff([node, node2], [node]);
      expect(actions.length, equals(1));
      expect(actions[0].node, equals(node2));
      expect(actions[0].XPATH, equals('/*[2]'));
      expect(actions[0] is NodeDeletion, equals(true));
    });

    test(
        'A list of two single different nodes between base and target should return a delete for the base node and an update for the target node',
        () {
      var node1 = Node(type: 'a');
      var node2 = Node(type: 'b');
      var actions = TreeDiff.diff([node1], [node2]);
      expect(actions[0].node, equals(node1));
      expect(actions[0].XPATH, equals('/*[1]'));
      expect(actions[0] is NodeDeletion, equals(true));
      expect(actions[1].node, equals(node2));
      expect(actions[1].XPATH, equals('/*[1]'));
      expect(actions[1] is NodeInsertion, equals(true));
    });

    test('Same nodes should not generate actions', () {
      var node1 = Node(type: 'a');
      var node2 = Node(type: 'a');
      var actions = TreeDiff.diff([node1], [node2]);
      expect(actions.length, equals(0));
    });

    test('Same deep nodes should generate no actions', () {
      var node1 = Node(type: 'a', children: [Node(type: 'b')]);
      var node2 = Node(type: 'a', children: [Node(type: 'b')]);
      var actions = TreeDiff.diff([node1], [node2]);
      expect(actions.length, equals(0));
    });

    test('ordering matters', () {
      var node1 = Node(type: 'a', children: [Node(type: 'a')]);
      var node2 = Node(type: 'a', children: [Node(type: 'b')]);
      var actions = TreeDiff.diff([node2, node1], [node1, node2]);
      expect(actions.length, equals(4));
      expect(actions[0].node, equals(node2.children[0]));
      expect(actions[0].XPATH, equals('/*[1]/*[1]'));
      expect(actions[0] is NodeDeletion, equals(true));
      expect(actions[1].node, equals(node1.children[0]));
      expect(actions[1].XPATH, equals('/*[1]/*[1]'));
      expect(actions[1] is NodeInsertion, equals(true));
      expect(actions[2].node, equals(node1.children[0]));
      expect(actions[2].XPATH, equals('/*[2]/*[1]'));
      expect(actions[2] is NodeDeletion, equals(true));
      expect(actions[3].node, equals(node2.children[0]));
      expect(actions[3].XPATH, equals('/*[2]/*[1]'));
      expect(actions[3] is NodeInsertion, equals(true));
    });

    test('different deep nodes should generate actions', () {
      var node1 = Node(type: 'a', children: [Node(type: 'a')]);
      var node2 = Node(type: 'a', children: [Node(type: 'b')]);
      var actions = TreeDiff.diff([node1], [node2]);
      expect(actions.length, equals(2));
    });
  });
}
