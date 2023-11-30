import 'package:qlsvnhom3/models/teacher_model/teacher_model.dart';

abstract class BaseTeacherRepository {
  Stream<TeacherModel> getStudent(String userName);
}
