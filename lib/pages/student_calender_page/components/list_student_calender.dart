import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timeline_calendar/timeline/model/datetime.dart';
import 'package:qlsvnhom3/blocs/student_calender_bloc/student_calender_bloc.dart';
import 'package:qlsvnhom3/constants/title_consts.dart';

import 'package:qlsvnhom3/models/student_calender_model/student_calender_model.dart';
import 'package:qlsvnhom3/pages/widgets/snack_processdata.dart';

class ListStudentCalender extends StatefulWidget {
  const ListStudentCalender({
    Key? key,
    required this.selectedDateTime,
    required this.studentCalender,
  }) : super(key: key);

  final CalendarDateTime selectedDateTime;
  final StudentCalenderModel studentCalender;

  @override
  State<ListStudentCalender> createState() => _ListStudentCalenderState();
}

class _ListStudentCalenderState extends State<ListStudentCalender> {
  late CalendarDateTime selectedDateTime;
  late List<LichMonHoc> danhSach = [];
  late List<LichMonHoc> lichHocHomNay = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      selectedDateTime = widget.selectedDateTime;
      danhSach = widget.studentCalender.danhsach ?? [];
      lichHocHomNay = getLichHocHomNay();
    });
  }

  @override
  void didUpdateWidget(covariant ListStudentCalender oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedDateTime != widget.selectedDateTime) {
      setState(() {
        selectedDateTime = widget.selectedDateTime;
        lichHocHomNay = getLichHocHomNay();
      });
    }

    if (listEquals(oldWidget.studentCalender.danhsach,
            widget.studentCalender.danhsach) ==
        false) {
      setState(() {
        danhSach = widget.studentCalender.danhsach ?? [];
        lichHocHomNay = getLichHocHomNay();
      });
    }
  }

////////////////////////////////////////////////////////////////////////////////
  getLichHocHomNay() {
    return danhSach.where((element) {
      final lichHoc = element.lichHoc?.where((element) {
            final tg = element.tgHoc;
            if (tg != null) {
              if (tg.day == selectedDateTime.day &&
                  tg.month == selectedDateTime.month &&
                  tg.year == selectedDateTime.year) return true;
            }
            return false;
          }).toList() ??
          [];

      if (lichHoc.isNotEmpty) return true;

      return false;
    }).toList();
  }

  getThoiGianMonHoc(index) {
    final tgHoc = lichHocHomNay[index].lichHoc?.firstWhere((element) {
      final tg = element.tgHoc;

      if (tg != null) {
        if (tg.day == selectedDateTime.day &&
            tg.month == selectedDateTime.month &&
            tg.year == selectedDateTime.year) return true;
      }
      return false;
    }).tgHoc;

    return tgHoc != null
        ? '${TitleConsts.batDauluc}: ${tgHoc.hour}:${convertNumberToString(tgHoc.minute)}'
        : '';
  }

  getDiemDanhMonHoc(index) {
    return lichHocHomNay[index].lichHoc?.firstWhere((element) {
      final tg = element.tgHoc;

      if (tg != null) {
        if (tg.day == selectedDateTime.day &&
            tg.month == selectedDateTime.month &&
            tg.year == selectedDateTime.year) return true;
      }
      return false;
    }).daDiemDanh;
  }

////////////////////////////////////////////////////////////////////////////////
  updateDiemDanh(BuildContext context, int index, bool diemDanh) async {
    final ixDiemDanh = lichHocHomNay[index].lichHoc?.indexWhere((element) {
          final tg = element.tgHoc;
          if (tg != null) {
            if (tg.day == selectedDateTime.day &&
                tg.month == selectedDateTime.month &&
                tg.year == selectedDateTime.year) return true;
          }
          return false;
        }) ??
        -1;

    final indexMonHoc = danhSach
        .indexWhere((element) => element.maLop == lichHocHomNay[index].maLop);

    if (ixDiemDanh != -1) {
      print('indexMonHoc: $indexMonHoc');
      danhSach[indexMonHoc].lichHoc?[ixDiemDanh].daDiemDanh = diemDanh;

      context.read<StudentCalenderBloc>().add(StudentCalenderUpdated(
          studentCalender: widget.studentCalender, danhSach: danhSach));

      snackProcessData(context);
    }
  }

////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return lichHocHomNay.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: lichHocHomNay.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                secondary: const Icon(Icons.school_outlined),
                title: Text(lichHocHomNay[index].tenMH ?? ''),
                subtitle: Text(getThoiGianMonHoc(index)),
                value: getDiemDanhMonHoc(index),
                enabled: getDiemDanhMonHoc(index) == false ? true : false,
                onChanged: (bool? value) async {
                  setState(() {
                    updateDiemDanh(context, index, value ?? false);
                  });
                },
              );
            },
          )
        : Container();
  }
}

String convertNumberToString(int number) {
  return number.toString().padLeft(2, '0');
}
