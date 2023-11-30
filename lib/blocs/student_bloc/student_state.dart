part of 'student_bloc.dart';

enum StudentStatus { loading, loaded }

class StudentState extends Equatable {
  final StudentStatus status;
  final StudentModel student;

  const StudentState._({
    this.status = StudentStatus.loading,
    this.student = StudentModel.empty,
  });

  const StudentState.loading() : this._();

  const StudentState.loaded({
    required StudentModel student,
  }) : this._(
          status: StudentStatus.loaded,
          student: student,
        );

  @override
  List<Object?> get props => [status, student];
}
