part of 'teacher_bloc.dart';

abstract class TeacherEvent extends Equatable {
  const TeacherEvent();

  @override
  List<Object?> get props => [];
}

class LoadTeacher extends TeacherEvent {
  final TeacherModel teacher;
  const LoadTeacher(this.teacher);

  @override
  List<Object?> get props => [teacher];
}
