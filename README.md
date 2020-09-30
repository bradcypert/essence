<p align="center">
  <img src="https://user-images.githubusercontent.com/1455979/94745619-0f5a3c80-0349-11eb-89b2-3954653e9f15.png" width="100" />
  <h1 align="center">Essence</h1>
</p>

Essence is a super-simple Virtual DOM implementation in Dart.

Essence can parse DOM-Strings into Essence Nodes.

Essence can diff Essence Nodes and provide a list of actions on how to go from NodeList A to NodeList B.
## Usage

A simple usage example:

```dart
import 'package:essence/essence.dart';

main() {
  var tree1 = TreeParser.parse("<a></a>");
  var tree2 = TreeParser.parse("<b></b>");
  TreeDiff.diff(tree1, tree2).forEach((action) => {
    print(action.node);
    print(action.XPATH);
  });
}
```

For more examples, please see our tests.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/bradcypert/essence/issues
