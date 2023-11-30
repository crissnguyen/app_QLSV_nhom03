part of 'class_bloc.dart';

abstract class ClassEvent extends Equatable {
  const ClassEvent();

  @override
  List<Object?> get props => [];
}

class LoadClass extends ClassEvent {
  final ClassModel classModel;
  const LoadClass(this.classModel);

  @override
  List<Object?> get props => [classModel];
}
