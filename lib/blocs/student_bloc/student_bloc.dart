// ignore_for_file: unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/student_model/student_model.dart';
import '../../models/user_model/user_model.dart';
import '../../repositories/student_repository/student_repository.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc({
    required UserModel user,
    required StudentRepository studentRepository,
  })  : _user = user,
        _studentRepository = studentRepository,
        super(const StudentState.loading()) {
    on<LoadStudent>(_onLoadStudent);
    on<UpdateStudent>(_onUpdateStudent);

    if (_user.isNotEmpty) {
      _studentSubcription = _studentRepository
          .getStudent(_user.username!)
          .listen((student) => add(LoadStudent(student)));
    }
  }

  final UserModel _user;
  final StudentRepository _studentRepository;
  late final StreamSubscription<StudentModel> _studentSubcription;

  FutureOr<void> _onLoadStudent(LoadStudent event, Emitter<StudentState> emit) {
    final student = event.student;

    if (student.isNotEmpty) {
      emit(StudentState.loaded(student: student));
    }
  }

  FutureOr<void> _onUpdateStudent(
      UpdateStudent event, Emitter<StudentState> emit) {}

  @override
  Future<void> close() {
    _studentSubcription.cancel();
    return super.close();
  }
}
