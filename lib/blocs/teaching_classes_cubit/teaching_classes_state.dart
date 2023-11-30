// ignore_for_file: unused_element

part of 'teaching_classes_cubit.dart';

enum TeachingClassStatus { loading, loaded }

class TeachingClassesState extends Equatable {
  final TeachingClassStatus status;
  final List<LopDay> teachingClasses;

  const TeachingClassesState._({
    this.status = TeachingClassStatus.loading,
    this.teachingClasses = const [],
  });

  const TeachingClassesState.loading() : this._();

  const TeachingClassesState.loaded({
    required List<LopDay> teachingClasses,
  }) : this._(
          status: TeachingClassStatus.loaded,
          teachingClasses: teachingClasses,
        );

  @override
  List<Object> get props => [status, teachingClasses];
}
