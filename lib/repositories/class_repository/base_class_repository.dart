import 'package:qlsvnhom3/models/class_model/class_model.dart';

abstract class BaseClassRepository {
  Stream<ClassModel> getClass(String uidClass);
}
