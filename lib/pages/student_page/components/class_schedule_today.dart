import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlsvnhom3/blocs/student_calender_bloc/student_calender_bloc.dart';
import 'package:qlsvnhom3/constants/title_consts.dart';
import 'package:qlsvnhom3/models/student_calender_model/student_calender_model.dart';
import 'package:qlsvnhom3/repositories/student_calender_repository/student_calender_repository.dart';

class ClassScheduleToday extends StatefulWidget {
  const ClassScheduleToday({
    Key? key,
    required this.mssv,
  }) : super(key: key);

  final String mssv;

  @override
  State<ClassScheduleToday> createState() => _ClassScheduleTodayState();
}

class _ClassScheduleTodayState extends State<ClassScheduleToday> {
  late String mssv;
  late DateTime timeToday;

  @override
  void initState() {
    super.initState();

    setState(() {
      mssv = widget.mssv;
      timeToday = DateTime.now();
    });
  }

  @override
  void didUpdateWidget(covariant ClassScheduleToday oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mssv != widget.mssv) {
      setState(() {
        mssv = widget.mssv;
      });
    }
  }

////////////////////////////////////////////////////////////////////////////////
  getLichHocHomNay(List<LichMonHoc> danhSach) {
    return danhSach.where((element) {
      final lichHoc = element.lichHoc?.where((element) {
            final tg = element.tgHoc;
            if (tg != null) {
              if (tg.day == timeToday.day &&
                  tg.month == timeToday.month &&
                  tg.year == timeToday.year) return true;
            }
            return false;
          }).toList() ??
          [];

      if (lichHoc.isNotEmpty) return true;

      return false;
    }).toList();
  }

  getThoiGianMonHoc(index, List<LichMonHoc> lichHocHomNay) {
    final tgHoc = lichHocHomNay[index].lichHoc?.firstWhere((element) {
      final tg = element.tgHoc;

      if (tg != null) {
        if (tg.day == timeToday.day &&
            tg.month == timeToday.month &&
            tg.year == timeToday.year) return true;
      }
      return false;
    }).tgHoc;

    return tgHoc != null
        ? '${TitleConsts.batDauluc}: ${tgHoc.hour}:${convertNumberToString(tgHoc.minute)}'
        : '';
  }

////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TitleConsts.lichhocHN,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Center(
          child:
              mssv.isNotEmpty ? _blocClassScheduleToDay(context) : Container(),
        ),
      ],
    );
  }

  //////////////////////////////////////////////////////////////////////////////

  _blocClassScheduleToDay(context) {
    return BlocProvider(
      create: (context) => StudentCalenderBloc(
        mssv: mssv,
        studentCalenderRepository: StudentCalenderRepository(),
      ),
      child: BlocBuilder<StudentCalenderBloc, StudentCalenderState>(
        builder: (context, state) {
          final studentCalender = state.studentCalender;

          final danhSach = studentCalender.danhsach ?? [];

          if (danhSach.isNotEmpty) {
            final lichHocHomNay = getLichHocHomNay(danhSach);

            return _listLichHocHomNay(context, lichHocHomNay);
          }

          return Container();
        },
      ),
    );
  }

  _listLichHocHomNay(context, List<LichMonHoc> lichHocHomNay) {
    return lichHocHomNay.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(4.0),
            itemCount: lichHocHomNay.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const Icon(Icons.school_outlined),
                title: Text(lichHocHomNay[index].tenMH ?? ''),
                subtitle: Text(getThoiGianMonHoc(index, lichHocHomNay)),
              );
            },
          )
        : Container();
  }
}

String convertNumberToString(int number) {
  return number.toString().padLeft(2, '0');
}
