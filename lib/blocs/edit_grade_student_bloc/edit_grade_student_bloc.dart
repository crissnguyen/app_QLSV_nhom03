// ignore_for_file: unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qlsvnhom3/models/scoreboard_model/scoreboard_model.dart';
import 'package:qlsvnhom3/repositories/scoreboard_repository/scoreboard_repository.dart';

part 'edit_grade_student_event.dart';
part 'edit_grade_student_state.dart';

class EditGradeStudentBloc
    extends Bloc<EditGradeStudentEvent, EditGradeStudentState> {
  EditGradeStudentBloc({
    required String mssv,
    required String maLop,
    required DiemMH diemMH,
    required ScoreBoardRepository scoreBoardRepository,
  })  : _mssv = mssv,
        _maLop = maLop,
        _diemMH = DiemMH.empty,
        _scoreBoardRepository = scoreBoardRepository,
        super(const EditGradeStudentState()) {
    on<EditGradeLoaded>(_onLoaded);
    on<EditGradeSubmitted>(_onSubmitted);

    if (_mssv.isNotEmpty && _maLop.isNotEmpty) {
      _diemMHSubcription =
          _scoreBoardRepository.getdiemMN(_mssv, _maLop).listen((value) {
        _diemMH = value.copyWith();

        if (_diemMH.isNotEmpty) {
          add(EditGradeLoaded(
              lyThuyet: _diemMH.lyThuyet ?? -1,
              thucHanh: _diemMH.thucHanh ?? -1,
              cuoiKy: _diemMH.cuoiKy ?? -1));
        }
      });
    }
  }

  final String _mssv;
  final String _maLop;
  late DiemMH _diemMH;
  final ScoreBoardRepository _scoreBoardRepository;
  late final StreamSubscription<DiemMH> _diemMHSubcription;

  FutureOr<void> _onLoaded(
      EditGradeLoaded event, Emitter<EditGradeStudentState> emit) {
    if (event.cuoiKy == -1 || event.thucHanh == -1 || event.lyThuyet == -1) {
      emit(state.copyWith(
        status: EditGradeStatus.failure,
      ));
    }

    emit(state.copyWith(
      status: EditGradeStatus.loaded,
      lyThuyet: event.lyThuyet,
      thucHanh: event.thucHanh,
      cuoiKy: event.cuoiKy,
    ));
  }

  FutureOr<void> _onSubmitted(
      EditGradeSubmitted event, Emitter<EditGradeStudentState> emit) async {
    String mess = 'error';

    if (event.lyThuyet > -1 && event.thucHanh > -1 && event.cuoiKy > -1) {
      mess = await _scoreBoardRepository.updateDiemMH(
          _mssv,
          _diemMH.copyWith(
            lyThuyet: event.lyThuyet,
            thucHanh: event.thucHanh,
            cuoiKy: event.cuoiKy,
          ));
    }

    if (event.lyThuyet > -1) {
      mess = await _scoreBoardRepository.updateDiemMH(
          _mssv,
          _diemMH.copyWith(
            lyThuyet: event.lyThuyet,
          ));
    }

    if (event.thucHanh > -1) {
      mess = await _scoreBoardRepository.updateDiemMH(
          _mssv,
          _diemMH.copyWith(
            thucHanh: event.thucHanh,
          ));
    }

    if (event.cuoiKy > -1) {
      mess = await _scoreBoardRepository.updateDiemMH(
          _mssv,
          _diemMH.copyWith(
            cuoiKy: event.cuoiKy,
          ));
    }

    if (mess == 'ok') {
      emit(state.copyWith(status: EditGradeStatus.success));
    } else {
      emit(state.copyWith(status: EditGradeStatus.failure));
    }
  }

  @override
  Future<void> close() {
    _diemMHSubcription.cancel();
    return super.close();
  }
}
