import 'package:polymer/polymer.dart';

import 'my_polymer_expressions.dart';

class MainElement extends PolymerElement {

  MainElement.created() : super.created();

  @override
  bool get applyAuthorStyles => true;

  @override
  BindingDelegate syntax = MyPolymerExpressions.INSTANCE;

}