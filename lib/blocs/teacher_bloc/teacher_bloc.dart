// ignore_for_file: unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:qlsvnhom3/models/teacher_model/teacher_model.dart';
import 'package:qlsvnhom3/models/user_model/user_model.dart';
import 'package:qlsvnhom3/repositories/teacher_repository/teacher_repository.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  TeacherBloc({
    required UserModel user,
    required TeacherRepository teacherRepository,
  })  : _user = user,
        _teacherRepository = teacherRepository,
        super(const TeacherState.loading()) {
    on<LoadTeacher>(_onLoadTeacher);

    if ((_user.isNotEmpty)) {
      _teacherSubcription = _teacherRepository
          .getStudent(_user.username!)
          .listen((teacher) => add(LoadTeacher(teacher)));
    }
  }

  final UserModel _user;
  final TeacherRepository _teacherRepository;
  late final StreamSubscription<TeacherModel> _teacherSubcription;

  FutureOr<void> _onLoadTeacher(LoadTeacher event, Emitter<TeacherState> emit) {
    final teacher = event.teacher;

    if (teacher.isNotEmpty) {
      emit(TeacherState.loaded(teacher: teacher));
    }
  }

  @override
  Future<void> close() {
    _teacherSubcription.cancel();
    return super.close();
  }
}
