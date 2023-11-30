// ignore_for_file: unused_field, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlsvnhom3/blocs/scoreboard_bloc/scoreboard_bloc.dart';
import 'package:qlsvnhom3/pages/scoreboard_page/components/scoretile.dart';
import 'package:qlsvnhom3/pages/widgets/drawer_app.dart';
import 'package:qlsvnhom3/repositories/scoreboard_repository/scoreboard_repository.dart';
import 'package:qlsvnhom3/routes.dart';

import '../../constants/title_consts.dart';
import '../../models/scoreboard_model/scoreboard_model.dart';
import '../../models/student_model/student_model.dart';

class ScoreBoardPage extends StatefulWidget {
  static const routeName = PAGE_SCOREBOARD;

  const ScoreBoardPage({
    Key? key,
    required StudentModel student,
  })  : _student = student,
        super(key: key);

  final StudentModel _student;

  @override
  State<ScoreBoardPage> createState() => _ScoreBoardPageState();
}

class _ScoreBoardPageState extends State<ScoreBoardPage> {
  late StudentModel student;

  @override
  void initState() {
    super.initState();
    student = widget._student;
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
          title: const Text(TitleConsts.bangdiem),
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
        body: _blocScoreBoard(context),
      ),
    );
  }

  _blocScoreBoard(context) {
    return BlocProvider(
      create: (context) => ScoreBoardBloc(
        mssv: student.mssv,
        scoreBoardRepository: ScoreBoardRepository(),
      ),
      child: BlocConsumer<ScoreBoardBloc, ScoreBoardState>(
        listener: (context, state) {
          print('scoreBoard: ${state.status}');
        },
        builder: (context, state) {
          final _scoreBoard = state.scoreBoard;
          return _scoreBoardBody(context, _scoreBoard);
        },
      ),
    );
  }

  _scoreBoardBody(context, ScoreBoardModel scoreBoard) {
    final List<DiemMH> data = scoreBoard.data ?? [];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ScoreTile(
            tenMH: data[index].tenMH ?? '',
            lyThuyet: data[index].lyThuyet ?? 0,
            thucHanh: data[index].thucHanh ?? 0,
            cuoiKy: data[index].cuoiKy ?? 0);
      },
    );
  }
}
