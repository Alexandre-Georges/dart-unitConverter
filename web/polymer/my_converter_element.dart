library my_polymer_my_converter_element;

import 'package:polymer/polymer.dart';

import '../model/import.dart';
import '../builder/import.dart';

import 'main_element.dart';

@CustomTag('my-converter')
class MyConverterElement extends MainElement {
  
  @observable
  List<Model> models = toObservable([]);
  
  static final List<String> COLORS = ['#ffff00', '#14d100', '#ffad00', '#a6a600'];

  MyConverterElement.created() : super.created() {
    models
      ..add(DISTANCE)
      ..add(TEMPERATURE)
      ..add(WEIGHT);
  }
  
  String getColor(int index) {
    return COLORS[index % COLORS.length];
  }
}
