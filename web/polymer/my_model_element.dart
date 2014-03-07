import 'package:polymer/polymer.dart';

import '../observers/object_change_record.dart';
import '../observers/object_observer.dart';
import '../observers/list_object_observer.dart';

import 'main_element.dart';

import '../model/unit.dart';
import '../model/model.dart';

@CustomTag('my-model')
class MyModelElement extends MainElement {

  @published
  Model model = null;

  List<Unit> unitToIgnore = [];

  MyModelElement.created() : super.created();

  void enteredView() {
    super.enteredView();

    ListObjectObserver<Unit, double> observer = new ListObjectObserver<Unit, double>(this.model.units, 'value');
    observer.changes.listen(this.updateUnit);

    ObjectObserver<Unit, double> referenceObserver = new ObjectObserver<Unit, double>(this.model.referenceUnit, 'value');
    referenceObserver.changes.listen(this.updateUnit);
  }

  void updateUnit(List<ObjectChangeRecord> changeRecords) {
    if (this.unitToIgnore.length > 0) {
      changeRecords.forEach((ObjectChangeRecord objectChangeRecord) {
        print('removeUnit ' + (objectChangeRecord.object as Unit).name);
        unitToIgnore.remove(objectChangeRecord.object);
      });
    } else {
      Unit currentUnit = changeRecords.last.object as Unit;
      print('updateUnit ' + currentUnit.name);

      this.unitToIgnore.addAll(this.model.units);
      this.unitToIgnore.remove(currentUnit);

      this.model.updateUnitValues(currentUnit);
    }
  }
}