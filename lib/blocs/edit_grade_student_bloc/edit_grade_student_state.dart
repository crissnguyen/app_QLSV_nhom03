part of 'edit_grade_student_bloc.dart';

enum EditGradeStatus { loading, loaded, success, failure }

class EditGradeStudentState extends Equatable {
  const EditGradeStudentState({
    this.status = EditGradeStatus.loading,
    this.lyThuyet = 0,
    this.thucHanh = 0,
    this.cuoiKy = 0,
  });

  final EditGradeStatus status;
  final double lyThuyet;
  final double thucHanh;
  final double cuoiKy;

  EditGradeStudentState copyWith({
    EditGradeStatus? status,
    double? lyThuyet,
    double? thucHanh,
    double? cuoiKy,
  }) {
    return EditGradeStudentState(
      status: status ?? this.status,
      lyThuyet: lyThuyet ?? this.lyThuyet,
      thucHanh: thucHanh ?? this.thucHanh,
      cuoiKy: cuoiKy ?? this.cuoiKy,
    );
  }

  @override
  List<Object?> get props => [status, lyThuyet, thucHanh, cuoiKy];
}
