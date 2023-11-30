// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlsvnhom3/models/student_model/student_model.dart';

import 'base_student_repository.dart';

class StudentRepository extends BaseStudentRepository {
  final FirebaseFirestore _firebaseFirestore;

  StudentRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<StudentModel> getStudent(String userName) {
    print('Getting student data from Cloud Firestore');
    return _firebaseFirestore
        .collection('students')
        .doc(userName)
        .snapshots()
        .map((map) {
      if (map.exists) {
        return StudentModel.fromMap(map.data()!);
      } else {
        return StudentModel.empty;
      }
    });
  }

  @override
  Future<void> updateStudent(StudentModel student) {
    throw UnimplementedError();
  }
}
