// ignore_for_file: unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qlsvnhom3/models/student_calender_model/student_calender_model.dart';
import 'package:qlsvnhom3/repositories/student_calender_repository/student_calender_repository.dart';

part 'student_calender_event.dart';
part 'student_calender_state.dart';

class StudentCalenderBloc
    extends Bloc<StudentCalenderEvent, StudentCalenderState> {
  StudentCalenderBloc({
    required String mssv,
    required StudentCalenderRepository studentCalenderRepository,
  })  : _mssv = mssv,
        _studentCalenderRepository = studentCalenderRepository,
        super(const StudentCalenderState(
            status: StudentCalenderStatus.loading,
            studentCalender: StudentCalenderModel.empty)) {
    on<StudentCalenderLoaded>(_onLoaded);
    on<StudentCalenderUpdated>(_onUpdate);

    if (_mssv.isNotEmpty) {
      _studentCalenderSubcription = _studentCalenderRepository
          .getStudentCalender(_mssv)
          .listen((studentCalender) =>
              add(StudentCalenderLoaded(studentCalender: studentCalender)));
    }
  }

  final String _mssv;
  final StudentCalenderRepository _studentCalenderRepository;
  late final StreamSubscription<StudentCalenderModel>
      _studentCalenderSubcription;

  @override
  Future<void> close() {
    _studentCalenderSubcription.cancel();
    return super.close();
  }

  FutureOr<void> _onLoaded(
      StudentCalenderLoaded event, Emitter<StudentCalenderState> emit) {
    final studentCalender = event.studentCalender;
    if (studentCalender.isNotEmpty) {
      emit(state.copyWith(
        status: StudentCalenderStatus.loaded,
        studentCalender: studentCalender,
      ));
    } else {
      emit(state.copyWith(
        status: StudentCalenderStatus.failure,
      ));
    }
  }

  FutureOr<void> _onUpdate(
      StudentCalenderUpdated event, Emitter<StudentCalenderState> emit) async {
    final danhSach = event.danhSach;
    if (danhSach.isNotEmpty) {
      final mess = await _studentCalenderRepository.updateDiemDanh(
          event.studentCalender.uid, danhSach);
      if (mess == 'ok') {
        emit(state.copyWith(
          status: StudentCalenderStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: StudentCalenderStatus.failure,
        ));
      }
    } else {
      emit(state.copyWith(
        status: StudentCalenderStatus.failure,
      ));
    }
  }
}
