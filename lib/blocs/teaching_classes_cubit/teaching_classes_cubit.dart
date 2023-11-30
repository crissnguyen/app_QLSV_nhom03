// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qlsvnhom3/models/teacher_model/teacher_model.dart';

part 'teaching_classes_state.dart';

class TeachingClassesCubit extends Cubit<TeachingClassesState> {
  TeachingClassesCubit({
    required List<LopDay> teachingClasses,
  })  : _teachingClasses = teachingClasses,
        super(const TeachingClassesState.loading()) {
    if (_teachingClasses.isNotEmpty) {
      emit(TeachingClassesState.loaded(teachingClasses: _teachingClasses));
    }
  }
  final List<LopDay> _teachingClasses;
}
