import 'package:qlsvnhom3/models/scoreboard_model/scoreboard_model.dart';

abstract class BaseScoreboardRepository {
  Stream<ScoreBoardModel> getScoreBoard(String mssv);
  Stream<DiemMH> getdiemMN(String mssv, String maLop);

  Future<String> updateDiemMH(String mssv, DiemMH diemMH);
}
