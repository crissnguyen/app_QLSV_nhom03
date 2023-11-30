import '../../models/student_model/student_model.dart';

abstract class BaseStudentRepository {
  Stream<StudentModel> getStudent(String userName);
  Future<void> updateStudent(StudentModel student);
}
