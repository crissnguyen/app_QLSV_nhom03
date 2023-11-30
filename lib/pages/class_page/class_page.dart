// ignore_for_file: unused_field, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlsvnhom3/blocs/class_bloc/class_bloc.dart';
import 'package:qlsvnhom3/constants/title_consts.dart';
import 'package:qlsvnhom3/models/class_model/class_model.dart';
import 'package:qlsvnhom3/pages/class_page/components/infor_class_card.dart';
import 'package:qlsvnhom3/pages/class_page/components/students_class_list.dart';
import 'package:qlsvnhom3/pages/widgets/drawer_app.dart';

import 'package:qlsvnhom3/repositories/class_repository/class_repository.dart';
import 'package:qlsvnhom3/routes.dart';

class ClassPage extends StatefulWidget {
  static const routeName = PAGE_CLASS;

  const ClassPage({
    Key? key,
    required String uidClass,
  })  : _uidClass = uidClass,
        super(key: key);

  final String _uidClass;

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final String uidClass;

  @override
  void initState() {
    super.initState();
    uidClass = widget._uidClass;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClassBloc(
        uidClass: uidClass,
        classRepository: ClassRepository(),
      ),
      child: BlocConsumer<ClassBloc, ClassState>(
        listener: (context, state) {},
        builder: (context, state) {
          final _classModel = state.classModel;
          return _classForm(context, _classModel);
        },
      ),
    );
  }

  _classForm(context, ClassModel classModel) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerApp(),
      appBar: AppBar(
        title: Text(classModel.maLop),
        leading: IconButton(
          tooltip: TitleConsts.back,
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () => Navigator.pop(context),
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
      body: _classBody(context, classModel),
    );
  }

  _classBody(context, ClassModel classModel) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InforClassCard(
            tenMH: classModel.tenMH,
            maPH: classModel.maPH,
            maCa: classModel.maCa,
            thu: classModel.thu,
            tgBatDau: classModel.tgBatDau,
            tgKetThuc: classModel.tgKetThuc,
          ),
          const SizedBox(height: 20),
          Text(
            TitleConsts.danhsachSV,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          StudentClassList(
            maLop: classModel.maLop,
            danhSachSV: classModel.danhSachSV ?? [],
          ),
        ],
      ),
    );
  }
}
