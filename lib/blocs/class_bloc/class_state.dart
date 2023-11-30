// ignore_for_file: unused_element

part of 'class_bloc.dart';

enum ClassStatus { loading, loaded }

class ClassState extends Equatable {
  final ClassStatus status;
  final ClassModel classModel;

  const ClassState._({
    this.status = ClassStatus.loading,
    this.classModel = ClassModel.empty,
  });

  const ClassState.loading() : this._();

  const ClassState.loaded({
    required ClassModel classModel,
  }) : this._(
          status: ClassStatus.loaded,
          classModel: classModel,
        );

  @override
  List<Object> get props => [status, classModel];
}
