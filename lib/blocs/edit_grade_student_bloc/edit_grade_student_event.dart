part of 'edit_grade_student_bloc.dart';

sealed class EditGradeStudentEvent extends Equatable {
  const EditGradeStudentEvent();

  @override
  List<Object?> get props => [];
}

final class EditGradeLoaded extends EditGradeStudentEvent {
  const EditGradeLoaded(
      {required this.lyThuyet, required this.thucHanh, required this.cuoiKy});

  final double lyThuyet;
  final double thucHanh;
  final double cuoiKy;

  @override
  List<Object> get props => [lyThuyet, thucHanh, cuoiKy];
}

final class EditGradeSubmitted extends EditGradeStudentEvent {
  const EditGradeSubmitted(
      {required this.lyThuyet, required this.thucHanh, required this.cuoiKy});

  final double lyThuyet;
  final double thucHanh;
  final double cuoiKy;

  @override
  List<Object> get props => [lyThuyet, thucHanh, cuoiKy];
}
