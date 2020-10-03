import 'package:test/test.dart';
import 'package:essence/essence.dart';
import 'package:universal_html/html.dart';

void main() {
  group('HTML Test', () {
    test('works with dart:html', () {
      var element = Element.div();
      element.className = 'root';
      element.childNodes.add(Element.span());

      var element2 = Element.div();
      element.className = 'root';
      element2.childNodes.add(Element.article());

      var eleParsed = TreeParser.parseElement(element);
      var ele2Parsed = TreeParser.parseElement(element2);
      var actions =
          TreeDiff.diff(eleParsed, ele2Parsed, currentSelector: '.root');
      actions.forEach((action) {
        print(
            '${action is NodeDeletion ? "Delete" : "Insert"} ${action.node.type} at selector ${action.selector}');
      });
    });
  });
}
