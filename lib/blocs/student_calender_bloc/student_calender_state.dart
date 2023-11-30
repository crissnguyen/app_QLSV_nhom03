part of 'student_calender_bloc.dart';

enum StudentCalenderStatus { loading, loaded, success, failure }

class StudentCalenderState extends Equatable {
  const StudentCalenderState(
      {required this.status, required this.studentCalender});

  final StudentCalenderStatus status;
  final StudentCalenderModel studentCalender;

  StudentCalenderState copyWith({
    StudentCalenderStatus? status,
    StudentCalenderModel? studentCalender,
  }) =>
      StudentCalenderState(
        status: status ?? this.status,
        studentCalender: studentCalender ?? this.studentCalender,
      );

  @override
  List<Object?> get props => [status, studentCalender];
}
