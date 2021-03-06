library my_polymer_my_model_element;

import 'package:polymer/polymer.dart';

import '../model/import.dart';
import '../observers/import.dart';

import 'main_element.dart';

@CustomTag('my-model')
class MyModelElement extends MainElement {

  @published
  Model model = null;
  @published
  String color = null;

  List<Unit> unitToIgnore = [];

  MyModelElement.created() : super.created();

  void attached() {

    ListObjectObserver<double> observer = new ListObjectObserver<double>(this.model.units, 'value');
    observer.changes.listen(this.updateUnit);

    ObjectObserver<double> referenceObserver = new ObjectObserver<double>(this.model.referenceUnit, 'value');
    referenceObserver.changes.listen(this.updateUnit);
  }

  void updateUnit(List<ObjectChangeRecord> changeRecords) {
    if (this.unitToIgnore.length > 0) {
      changeRecords.forEach((ObjectChangeRecord objectChangeRecord) {
        unitToIgnore.remove(objectChangeRecord.object);
      });
    } else {
      Unit currentUnit = changeRecords.last.object as Unit;

      this.unitToIgnore.add(this.model.referenceUnit);
      this.unitToIgnore.addAll(this.model.units);
      this.unitToIgnore.remove(currentUnit);

      this.model.updateUnitValues(currentUnit);
    }
  }
}