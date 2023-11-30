import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlsvnhom3/blocs/teacher_bloc/teacher_bloc.dart';
import 'package:qlsvnhom3/models/teacher_model/teacher_model.dart';
import 'package:qlsvnhom3/pages/widgets/drawer_app.dart';
import 'package:qlsvnhom3/repositories/teacher_repository/teacher_repository.dart';

import '../../constants/title_consts.dart';
import '../../repositories/user_repository/user_repository.dart';
import '../../routes.dart';
import 'components/list_card.dart';

class TeacherPage extends StatefulWidget {
  static const routeName = PAGE_TEACHER;
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userRepository = RepositoryProvider.of<UserRepository>(context);
    return BlocProvider(
      create: (context) => TeacherBloc(
        user: userRepository.currentUser,
        teacherRepository: TeacherRepository(),
      ),
      child: BlocConsumer<TeacherBloc, TeacherState>(
        listener: (context, state) {
          print('teacherStatus: ${state.status}');
        },
        builder: (context, state) {
          final teacher = state.teacher;
          return _teacherForm(context, teacher);
        },
      ),
    );
  }

  _teacherForm(context, TeacherModel teacher) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerApp(),
      appBar: AppBar(
        title: Text(teacher.ten ?? ''),
        leading: IconButton(
          tooltip: TitleConsts.menu,
          icon: const Icon(Icons.accessible),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
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
      body: _teacherBody(context, teacher),
    );
  }

  _teacherBody(context, TeacherModel teacher) {
    return GridView(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1,
      ),
      children: [
        ListCard(
            onTap: () {
              Navigator.pushNamed(context, PAGE_TEACHING_CLASSES,
                  arguments: teacher.lopDay ?? const []);
            },
            color: Colors.redAccent,
            icon: Icons.subject_outlined,
            text: TitleConsts.danhsachLophoc),
        ListCard(
            onTap: () {},
            color: Colors.blueAccent,
            icon: Icons.featured_play_list_outlined,
            text: TitleConsts.thongke),
      ],
    );
  }
}
