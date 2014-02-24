import 'unit.dart';
import '../converter/converter.dart';

class ReferenceUnit extends Unit {
  ReferenceUnit(String name) : super(name, IDENTITY, IDENTITY) {
    this.value = 0.0;
  }
}
