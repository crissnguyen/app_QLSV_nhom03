part of 'teacher_bloc.dart';

enum TeacherStatus { loading, loaded }

class TeacherState extends Equatable {
  final TeacherStatus status;
  final TeacherModel teacher;

  const TeacherState._({
    this.status = TeacherStatus.loading,
    this.teacher = TeacherModel.empty,
  });

  const TeacherState.loading() : this._();

  const TeacherState.loaded({
    required TeacherModel teacher,
  }) : this._(
          status: TeacherStatus.loaded,
          teacher: teacher,
        );

  @override
  List<Object?> get props => [status, teacher];
}
