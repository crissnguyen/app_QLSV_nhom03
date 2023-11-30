// ignore_for_file: unused_field, no_leading_underscores_for_local_identifiers, void_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qlsvnhom3/models/scoreboard_model/scoreboard_model.dart';

import 'base_scoreboard_repository.dart';

class ScoreBoardRepository extends BaseScoreboardRepository {
  final FirebaseFirestore _firebaseFirestore;

  ScoreBoardRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<ScoreBoardModel> getScoreBoard(String mssv) {
    print('Getting scoreBoard data from Cloud Firestore');

    return _firebaseFirestore
        .collection('scoreBoard')
        .where('mssv', isEqualTo: mssv)
        .snapshots()
        .map((query) {
      final map = query.docs.first.data();
      if (map.isNotEmpty) {
        return ScoreBoardModel.fromMap(map);
      }
      return ScoreBoardModel.empty;
    });
  }

  @override
  Stream<DiemMH> getdiemMN(String mssv, String maLop) {
    print('Getting DiemMH data from Cloud Firestore');

    return _firebaseFirestore
        .collection('scoreBoard')
        .where('mssv', isEqualTo: mssv)
        .snapshots()
        .map((query) {
      final map = query.docs.first.data();

      try {
        if (map.isNotEmpty) {
          final _scoreBoard = ScoreBoardModel.fromMap(map);
          return _scoreBoard.data
                  ?.singleWhere((diemMH) => diemMH.maLop == maLop) ??
              DiemMH.empty;
        }
      } catch (_) {
        return DiemMH.empty;
      }

      return DiemMH.empty;
    });
  }

  @override
  Future<String> updateDiemMH(String mssv, DiemMH diemMH) async {
    print('Updating DiemMH data to Cloud Firestore');

    return await _firebaseFirestore
        .collection('scoreBoard')
        .where('mssv', isEqualTo: mssv)
        .get()
        .then(
      (query) async {
        final map = query.docs.first.data();
        try {
          if (map.isEmpty) return 'error';

          final _scoreBoard = ScoreBoardModel.fromMap(map);
          final index = _scoreBoard.data
                  ?.indexWhere((element) => element.maLop == diemMH.maLop) ??
              -1;

          if (index == -1) return 'error';

          _scoreBoard.data?.setAll(index, [diemMH]);

          final _uid = _scoreBoard.uid;
          if (_uid == null) return 'error';

          await _firebaseFirestore
              .collection('scoreBoard')
              .doc(_uid)
              .update(_scoreBoard.toMap())
              .onError((error, stackTrace) => error.toString());

          return 'ok';
        } catch (_) {
          return 'error';
        }
      },
    );
  }
}
