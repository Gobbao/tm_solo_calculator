import 'package:flutter_test/flutter_test.dart';
import 'package:tm_solo_calculator/app/models/graph/spanning_tree_element.dart';

class SpanningTreeElementMatcher extends CustomMatcher {
  SpanningTreeElementMatcher(Matcher matcher)
      : super('SpanningTreeElement that is', 'object', matcher);

  @override
  Object featureValueOf(actual) {
    final actualAs = (actual as SpanningTreeElement);

    return {
      'vertex': actualAs.vertex,
      'parent': actualAs.parent,
      'cost': actualAs.cost,
      'weightToParent': actualAs.weightToParent,
    };
  }
}
