<p align="center">
  <img src="https://user-images.githubusercontent.com/1455979/94745619-0f5a3c80-0349-11eb-89b2-3954653e9f15.png" width="100" />
  <h1 align="center">Essence</h1>
</p>

Essence is a super-simple Virtual DOM implementation in Dart.

Essence can parse DOM-Strings into Essence Nodes.

Essence can diff Essence Nodes and provide a list of actions on how to go from NodeList A to NodeList B.

![Pub Version](https://img.shields.io/pub/v/essence?include_prereleases&style=for-the-badge)

## Usage

A simple usage example:

```dart
import 'package:essence/essence.dart';

main() {
  var tree1 = TreeParser.parse("<a></a>");
  var tree2 = TreeParser.parse("<b></b>");
  TreeDiff.diff(tree1, tree2).forEach((action) => {
    print(action.node);
    print(action.selector);
  });
}
```

More interesting perhaps, you can leverage those actions to make updates to an actual DOM. It's worth mentioning that these CSS selectors are unbounded by default. You can pass in a `currentSelector` to `TreeDiff`'s `diff` function to scope them.

```dart
import 'dart:html';
import 'package:essence/essence.dart';

main() {
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
  var actions =
      TreeDiff.diff(eleParsed, ele2Parsed, currentSelector: '.root');
  actions.forEach((action) {
    // ideally, do the action instead of just printing it, but Ill leave the code for that up to you :)
    print(
        '${action is NodeDeletion ? "Delete" : "Insert"} ${action.node.type} at selector ${action.selector}');
  });
}
```

For more examples, please see our tests.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/bradcypert/essence/issues
