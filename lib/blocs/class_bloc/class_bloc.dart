// ignore_for_file: unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qlsvnhom3/models/class_model/class_model.dart';
import 'package:qlsvnhom3/repositories/class_repository/class_repository.dart';

part 'class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc({
    required String uidClass,
    required ClassRepository classRepository,
  })  : _uidClass = uidClass,
        _classRepository = classRepository,
        super(const ClassState.loading()) {
    on<LoadClass>(_onLoadClass);
    _classSubcription = _classRepository
        .getClass(uidClass)
        .listen((classModel) => add(LoadClass(classModel)));
  }

  final String _uidClass;
  final ClassRepository _classRepository;
  late final StreamSubscription<ClassModel> _classSubcription;

  FutureOr<void> _onLoadClass(LoadClass event, Emitter<ClassState> emit) {
    final classModel = event.classModel;
    if (classModel.isNotEmpty) emit(ClassState.loaded(classModel: classModel));
  }

  @override
  Future<void> close() {
    _classSubcription.cancel();
    return super.close();
  }
}
