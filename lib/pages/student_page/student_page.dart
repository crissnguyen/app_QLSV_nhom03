import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlsvnhom3/blocs/student_bloc/student_bloc.dart';
import 'package:qlsvnhom3/constants/title_consts.dart';
import 'package:qlsvnhom3/models/student_model/student_model.dart';
import 'package:qlsvnhom3/pages/student_page/components/dashboard_student.dart';
import 'package:qlsvnhom3/pages/widgets/drawer_app.dart';
import 'package:qlsvnhom3/repositories/student_repository/student_repository.dart';

import '../../repositories/user_repository/user_repository.dart';
import '../../routes.dart';
import 'components/class_schedule_today.dart';
import 'components/upcoming_card.dart';

class StudentPage extends StatefulWidget {
  static const routeName = PAGE_STUDENT;
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerApp(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            clipBehavior: Clip.none,
            shape: const StadiumBorder(),
            scrolledUnderElevation: 0.0,
            titleSpacing: 0.0,
            backgroundColor: Colors.transparent,
            floating: true,
            centerTitle: true,
            title: SearchAnchor(
              viewElevation: 0,
              builder: (context, controller) {
                return SearchBar(
                  elevation: const MaterialStatePropertyAll(3.0),
                  constraints: const BoxConstraints(
                    minHeight: 50,
                  ),
                  controller: controller,
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                });
              },
            ),
            leading: IconButton(
              tooltip: TitleConsts.menu,
              icon: const Icon(Icons.accessible),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
                tooltip: TitleConsts.thongbao,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: _blocStudent(context),
          ),
        ],
      ),
    );
  }

  _blocStudent(context) {
    final userRepository = RepositoryProvider.of<UserRepository>(context);

    return BlocProvider(
      create: (context) => StudentBloc(
        user: userRepository.currentUser,
        studentRepository: StudentRepository(),
      ),
      child: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          print("StudentStatus: ${state.status}");
        },
        builder: (context, state) {
          final student = state.student;
          return _studentForm(context, student);
        },
      ),
    );
  }

  _studentForm(context, StudentModel student) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      children: [
        UpcomingCard(
          fullname: student.ten ?? '',
          mssv: student.mssv,
          gender: student.gioiTinh ?? '',
        ),
        const SizedBox(height: 20),
        Text(
          TitleConsts.menu,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
        DashboardStudent(student: student),
        const SizedBox(height: 25),
        ClassScheduleToday(
          mssv: student.mssv,
        ),
      ],
    );
  }
}
