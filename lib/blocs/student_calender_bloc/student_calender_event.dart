part of 'student_calender_bloc.dart';

abstract class StudentCalenderEvent extends Equatable {
  const StudentCalenderEvent();

  @override
  List<Object?> get props => [];
}

class StudentCalenderLoaded extends StudentCalenderEvent {
  final StudentCalenderModel studentCalender;

  const StudentCalenderLoaded({
    required this.studentCalender,
  });

  @override
  List<Object?> get props => [studentCalender];
}

class StudentCalenderUpdated extends StudentCalenderEvent {
  final StudentCalenderModel studentCalender;
  final List<LichMonHoc> danhSach;

  const StudentCalenderUpdated({
    required this.studentCalender,
    required this.danhSach,
  });

  @override
  List<Object?> get props => [studentCalender, danhSach];
}
