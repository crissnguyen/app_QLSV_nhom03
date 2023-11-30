// ignore_for_file: constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:qlsvnhom3/BlocNavigate.dart';
import 'package:qlsvnhom3/models/teacher_model/teacher_model.dart';
import 'package:qlsvnhom3/pages/class_page/class_page.dart';
import 'package:qlsvnhom3/pages/student_calender_page/student_calender_page.dart';

import 'pages/scoreboard_page/scoreboard_page.dart';
import 'pages/teacher_page/teacher_page.dart';
import 'pages/login_page/login_page.dart';
import 'pages/student_page/student_page.dart';
import 'pages/teaching_classes_page/teaching_classes_page.dart';

import 'models/student_model/student_model.dart';

const String BLOC_NAVIGATE = '/navigate';
const String PAGE_LOGIN = '/login';
const String PAGE_STUDENT = '/student';
const String PAGE_SCOREBOARD = '/scoreboard';
const String PAGE_TEACHER = '/teacher';
const String PAGE_TEACHING_CLASSES = '/teaching_classes';
const String PAGE_CLASS = '/class';
const String PAGE_STUDENT_CALENDER = '/student_calender';

Map<String, WidgetBuilder> materialRoutes = {
  BLOC_NAVIGATE: (context) => const BlocNavigate(),
  // route login_page.dart.
  PAGE_LOGIN: (context) => const LoginPage(),
  // route student_page.dart.
  PAGE_STUDENT: (context) => const StudentPage(),
  // route scoreboard_page.dart.
  PAGE_SCOREBOARD: (context) {
    final StudentModel _student =
        ModalRoute.of(context)!.settings.arguments as StudentModel;
    return ScoreBoardPage(
      student: _student,
    );
  },
  // route teacher_page.dart
  PAGE_TEACHER: (context) => const TeacherPage(),
  // route subjects_page.dart
  PAGE_TEACHING_CLASSES: (context) {
    final List<LopDay> _teachingClasses =
        ModalRoute.of(context)!.settings.arguments as List<LopDay>;
    return TeachingClassPage(
      teachingClasses: _teachingClasses,
    );
  },
  // route clas_page.dart
  PAGE_CLASS: (context) {
    final String _uidClass =
        ModalRoute.of(context)!.settings.arguments as String;
    return ClassPage(
      uidClass: _uidClass,
    );
  },
  // route student_calender_page.dart
  PAGE_STUDENT_CALENDER: (context) {
    final String _mssv = ModalRoute.of(context)!.settings.arguments as String;
    return StudentCalenderPage(mssv: _mssv);
  },
};
