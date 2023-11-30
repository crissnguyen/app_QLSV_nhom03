// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlsvnhom3/models/teacher_model/teacher_model.dart';

import 'base_teacher_repository.dart';

class TeacherRepository extends BaseTeacherRepository {
  final FirebaseFirestore _firebaseFirestore;

  TeacherRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<TeacherModel> getStudent(String userName) {
    print('Getting teacher data from Cloud Firestore');
    return _firebaseFirestore
        .collection('teachers')
        .doc(userName)
        .snapshots()
        .map((map) {
      if (map.exists) {
        return TeacherModel.fromMap(map.data()!);
      } else {
        return TeacherModel.empty;
      }
    });
  }
}
