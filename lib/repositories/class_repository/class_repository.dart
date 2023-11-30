// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlsvnhom3/models/class_model/class_model.dart';
import 'package:qlsvnhom3/repositories/class_repository/base_class_repository.dart';

class ClassRepository extends BaseClassRepository {
  final FirebaseFirestore _firebaseFirestore;

  ClassRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<ClassModel> getClass(String uidClass) {
    print('Getting class data from Cloud Firestore');

    return _firebaseFirestore
        .collection('classes')
        .doc(uidClass)
        .snapshots()
        .map((map) {
      if (map.exists) {
        return ClassModel.fromMap(map.data()!);
      }
      return ClassModel.empty;
    });
  }
}
