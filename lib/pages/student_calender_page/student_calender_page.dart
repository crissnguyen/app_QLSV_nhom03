import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timeline_calendar/timeline/model/calendar_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/datetime.dart';
import 'package:flutter_timeline_calendar/timeline/model/day_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/headers_options.dart';
import 'package:flutter_timeline_calendar/timeline/provider/instance_provider.dart';
import 'package:flutter_timeline_calendar/timeline/utils/calendar_types.dart';
import 'package:flutter_timeline_calendar/timeline/utils/datetime_extension.dart';
import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';

import 'package:qlsvnhom3/blocs/student_calender_bloc/student_calender_bloc.dart';
import 'package:qlsvnhom3/constants/title_consts.dart';
import 'package:qlsvnhom3/pages/student_calender_page/components/list_student_calender.dart';
import 'package:qlsvnhom3/repositories/student_calender_repository/student_calender_repository.dart';
import 'package:qlsvnhom3/routes.dart';

class StudentCalenderPage extends StatefulWidget {
  static const routeName = PAGE_STUDENT_CALENDER;
  const StudentCalenderPage({
    Key? key,
    required this.mssv,
  }) : super(key: key);

  final String mssv;

  @override
  State<StudentCalenderPage> createState() => _StudentCalenderPageState();
}

class _StudentCalenderPageState extends State<StudentCalenderPage> {
  late CalendarDateTime selectedDateTime;
  late DateTime? weekStart;
  late DateTime? weekEnd;

  late String mssv;

  @override
  void initState() {
    super.initState();
    mssv = widget.mssv;
    TimelineCalendar.calendarProvider = createInstance();
    selectedDateTime = TimelineCalendar.calendarProvider.getDateTime();
    getLatestWeek();
  }

  getLatestWeek() {
    setState(() {
      weekStart = selectedDateTime.toDateTime().findFirstDateOfTheWeek();
      weekEnd = selectedDateTime.toDateTime().findLastDateOfTheWeek();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thời Khóa Biểu"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
            tooltip: TitleConsts.timkiem,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
            tooltip: TitleConsts.thongbao,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
// lich add tkb
        children: <Widget>[
          _timelineCalendar(context),
          const SizedBox(height: 15),
          _blocStudentCalender(context),
        ],
      ),
    );
  }

  _blocStudentCalender(context) {
    return BlocProvider(
      create: (context) => StudentCalenderBloc(
        mssv: mssv,
        studentCalenderRepository: StudentCalenderRepository(),
      ),
      child: BlocConsumer<StudentCalenderBloc, StudentCalenderState>(
        listener: (context, state) {},
        builder: (context, state) {
          final studentCalender = state.studentCalender;

          final danhSach = studentCalender.danhsach ?? [];

          if (danhSach.isNotEmpty) {
            return ListStudentCalender(
                selectedDateTime: selectedDateTime,
                studentCalender: studentCalender);
          }
          return Container();
        },
      ),
    );
  }

  _timelineCalendar(context) {
    return TimelineCalendar(
      calendarType: CalendarType.GREGORIAN,
      calendarLanguage: "en",
      calendarOptions: CalendarOptions(
        weekStartDate: weekStart,
        weekEndDate: weekEnd,
        viewType: ViewType.DAILY,
        toggleViewType: true,
        headerMonthElevation: 12,
        headerMonthShadowColor: Theme.of(context).colorScheme.primaryContainer,
        headerMonthBackColor: Colors.transparent,
        bottomSheetBackColor: Theme.of(context).colorScheme.tertiaryContainer,
      ),
      dayOptions: DayOptions(
        compactMode: true,
        dayFontSize: 14.0,
        disableFadeEffect: true,
        differentStyleForToday: true,
        weekDaySelectedColor: Theme.of(context).colorScheme.secondary,
        todayTextColor: Theme.of(context).colorScheme.onSecondaryContainer,
        todayBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        selectedBackgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      headerOptions: HeaderOptions(
        weekDayStringType: WeekDayStringTypes.SHORT,
        monthStringType: MonthStringTypes.FULL,
        headerTextSize: 14,
        navigationColor: Theme.of(context).colorScheme.onPrimaryContainer,
        resetDateColor: Theme.of(context).colorScheme.onTertiaryContainer,
        calendarIconColor: Theme.of(context).colorScheme.onPrimaryContainer,
        headerTextColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      onChangeDateTime: (dateTime) {
        print("Date Change $dateTime");

        setState(() {
          selectedDateTime = dateTime;
          getLatestWeek();
        });
      },
      onDateTimeReset: (resetDateTime) {
        print("Date Reset $resetDateTime");

        setState(() {
          selectedDateTime = resetDateTime;
          getLatestWeek();
        });
      },
      onMonthChanged: (monthDateTime) {
        print("Month Change $monthDateTime");

        setState(() {
          selectedDateTime = monthDateTime;
          getLatestWeek();
        });
      },
      onYearChanged: (yearDateTime) {
        print("Year Change $yearDateTime");

        setState(() {
          selectedDateTime = yearDateTime;
          getLatestWeek();
        });
      },
      dateTime: selectedDateTime,
    );
  }
}
