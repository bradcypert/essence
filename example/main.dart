// import 'dart:html';
import 'package:universal_html/html.dart'; // you can use dart:html with dart2js
import 'package:essence/essence.dart';

void main() {
  // ideally, you'll generate these from dart:html's querySelector
  // but you can create them programatically, too!
  var element = Element.div();
  element.className = 'root';
  element.childNodes.add(Element.span());

  var element2 = Element.div();
  element.className = 'root';
  element2.childNodes.add(Element.article());

  var eleParsed = TreeParser.parseElement(element);
  var ele2Parsed = TreeParser.parseElement(element2);
  var actions = TreeDiff.diff(eleParsed, ele2Parsed, currentSelector: '.root');
  actions.forEach((action) {
    // ideally, do the action instead of just printing it, but Ill leave the code for that up to you :)
    print(
        '${action is NodeDeletion ? "Delete" : "Insert"} ${action.node.type} at selector ${action.selector}');
  });
}
