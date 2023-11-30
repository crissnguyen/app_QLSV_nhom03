// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qlsvnhom3/blocs/teaching_classes_cubit/teaching_classes_cubit.dart';
import 'package:qlsvnhom3/models/teacher_model/teacher_model.dart';
import 'package:qlsvnhom3/pages/widgets/drawer_app.dart';
import 'package:qlsvnhom3/routes.dart';

import '../../constants/title_consts.dart';

class TeachingClassPage extends StatefulWidget {
  static const routeName = PAGE_TEACHING_CLASSES;
  const TeachingClassPage({
    Key? key,
    required List<LopDay> teachingClasses,
  })  : _teachingClasses = teachingClasses,
        super(key: key);

  final List<LopDay> _teachingClasses;

  @override
  State<TeachingClassPage> createState() => _TeachingClassPageState();
}

class _TeachingClassPageState extends State<TeachingClassPage> {
  late final List<LopDay> teachingClasses;

  @override
  void initState() {
    super.initState();

    teachingClasses = widget._teachingClasses;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        drawer: const DrawerApp(),
        appBar: AppBar(
          leading: IconButton(
            tooltip: TitleConsts.back,
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(TitleConsts.danhsachLophoc),
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
        body: _cubitTeaching(context),
      ),
    );
  }

  _cubitTeaching(context) {
    return BlocProvider(
      create: (context) =>
          TeachingClassesCubit(teachingClasses: teachingClasses),
      child: BlocConsumer<TeachingClassesCubit, TeachingClassesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final teachingClasses = state.teachingClasses;
          return ListView.builder(
            itemCount: teachingClasses.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.book_outlined),
                title: Text(teachingClasses[index].maLop ?? ''),
                subtitle: Text(teachingClasses[index].tenMH ?? ''),
                onTap: () {
                  Navigator.pushNamed(context, PAGE_CLASS,
                      arguments: teachingClasses[index].maLop);
                },
              );
            },
          );
        },
      ),
    );
  }
}
