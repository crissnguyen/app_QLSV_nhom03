import 'package:qlsvnhom3/models/student_calender_model/student_calender_model.dart';

abstract class BaseStudentCalenderRepository {
  Stream<StudentCalenderModel> getStudentCalender(String mssv);
  Future<String> updateDiemDanh(String uid, List<LichMonHoc> danhSach);
}
