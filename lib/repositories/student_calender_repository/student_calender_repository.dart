// ignore_for_file: unused_field, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlsvnhom3/models/student_calender_model/student_calender_model.dart';

import 'base_student_calender_repository.dart';

class StudentCalenderRepository extends BaseStudentCalenderRepository {
  final FirebaseFirestore _firebaseFirestore;

  StudentCalenderRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<StudentCalenderModel> getStudentCalender(String mssv) {
    print('Getting StudentCalender data from Cloud Firestore');

    return _firebaseFirestore
        .collection('studentCalender')
        .where('mssv', isEqualTo: mssv)
        .snapshots()
        .map((query) {
      final map = query.docs.first.data();

      if (map.isNotEmpty) {
        return StudentCalenderModel.fromMap(map);
      }
      return StudentCalenderModel.empty;
    });
  }

  @override
  Future<String> updateDiemDanh(String uid, List<LichMonHoc> danhSach) async {
    print('Updating StudentCalender data from Cloud Firestore');

    return await _firebaseFirestore
        .collection('studentCalender')
        .doc(uid)
        .get()
        .then((map) async {
      if (map.exists) {
        final data = map.data();
        if (data == null) return 'error';
        final studentCalender = StudentCalenderModel.fromMap(data);

        try {
          final _studentCalender = studentCalender.copyWith(danhsach: danhSach);

          await _firebaseFirestore
              .collection('studentCalender')
              .doc(uid)
              .update(_studentCalender.toMap())
              .onError((error, stackTrace) => error.toString());

          return 'ok';
        } catch (e) {
          return 'error';
        }
      }

      return 'error';
    });
  }
}
