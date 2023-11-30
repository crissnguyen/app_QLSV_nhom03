part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object?> get props => [];
}

class LoadStudent extends StudentEvent {
  final StudentModel student;
  const LoadStudent(this.student);

  @override
  List<Object?> get props => [student];
}

class UpdateStudent extends StudentEvent {
  final StudentModel student;
  const UpdateStudent(this.student);

  @override
  List<Object?> get props => [student];
}
