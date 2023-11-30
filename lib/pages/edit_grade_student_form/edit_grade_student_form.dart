// ignore_for_file: unused_field, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlsvnhom3/blocs/edit_grade_student_bloc/edit_grade_student_bloc.dart';
import 'package:qlsvnhom3/constants/title_consts.dart';
import 'package:qlsvnhom3/models/scoreboard_model/scoreboard_model.dart';
import 'package:qlsvnhom3/pages/widgets/snack_processdata.dart';
import 'package:qlsvnhom3/repositories/scoreboard_repository/scoreboard_repository.dart';

class EditGradeStudentForm extends StatefulWidget {
  const EditGradeStudentForm({
    Key? key,
    required this.mssv,
    required this.maLop,
  }) : super(key: key);

  final String mssv;
  final String maLop;

  @override
  State<EditGradeStudentForm> createState() => _EditGradeStudentFormState();
}

class _EditGradeStudentFormState extends State<EditGradeStudentForm> {
  final _formKey = GlobalKey<FormState>();

  late final String mssv;
  late final String maLop;

  late double _lyThuyet = -1;
  late double _thucHanh = -1;
  late double _cuoiKy = -1;

  @override
  void initState() {
    super.initState();

    setState(() {
      mssv = widget.mssv;
      maLop = widget.maLop;
    });
  }

  @override
  void didUpdateWidget(covariant EditGradeStudentForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mssv != widget.mssv) {
      setState(() {
        mssv = widget.mssv;
      });
    }
    if (oldWidget.maLop != widget.maLop) {
      setState(() {
        maLop = widget.maLop;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditGradeStudentBloc(
        mssv: mssv,
        maLop: maLop,
        diemMH: DiemMH.empty,
        scoreBoardRepository: ScoreBoardRepository(),
      ),
      child: BlocConsumer<EditGradeStudentBloc, EditGradeStudentState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == EditGradeStatus.success,
        listener: (context, state) {
          snackProcessData(context);
          Navigator.pop(context);
        },
        buildWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == EditGradeStatus.loaded,
        builder: (context, state) {
          if (state.status == EditGradeStatus.loaded) {
            return Form(
              key: _formKey,
              child: _editForm(context, state),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withOpacity(0.8),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
                child: Center(child: Text(state.status.toString())),
              ),
            );
          }
        },
      ),
    );
  }

  _submittedGrade(BuildContext context, EditGradeStudentState state) {
    context.read<EditGradeStudentBloc>().add(EditGradeSubmitted(
        lyThuyet: _lyThuyet, thucHanh: _thucHanh, cuoiKy: _cuoiKy));
  }

  //////////////////////////////////////////////////////////////////////////////
  _editForm(context, state) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .secondaryContainer
                .withOpacity(0.8),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SafeArea(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _huyButton(context),
                    Text(
                      mssv,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    _thayDoiButton(context, state),
                  ],
                ),
              ),
              // Diem ly thuyet ////////////////////////////////////////////////
              _lyThuyetField(context, state),
              // Diem thuc hanh ////////////////////////////////////////////////
              _thucHanhField(context, state),
              // Diem cuoi ky //////////////////////////////////////////////////
              _cuoiKyField(context, state),
            ],
          ),
        ),
      ),
    );
  }

  _huyButton(context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(
        TitleConsts.huy,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }

  _thayDoiButton(context, state) {
    return TextButton(
      onPressed: () => _submittedGrade(context, state),
      child: Text(
        TitleConsts.thaydoi,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }

  _lyThuyetField(context, EditGradeStudentState state) {
    return TextFormField(
      key: const Key('lyThuyet'),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      initialValue: state.lyThuyet.toString(),
      onFieldSubmitted: (value) {
        setState(() {
          _lyThuyet = double.tryParse(value) ?? 0;
        });
      },
      decoration: InputDecoration(
        labelText: TitleConsts.lythuyet,
        labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSecondaryContainer),
        hintText: TitleConsts.lythuyet,
        hintStyle:
            TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.tertiaryContainer,
        prefixIcon: const Icon(Icons.book_outlined),
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary),
      ),
    );
  }

  _thucHanhField(context, EditGradeStudentState state) {
    return TextFormField(
      key: const Key('thucHanh'),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      initialValue: state.thucHanh.toString(),
      onFieldSubmitted: (value) {
        setState(() {
          _thucHanh = double.tryParse(value) ?? 0;
        });
      },
      decoration: InputDecoration(
        labelText: TitleConsts.thuchanh,
        labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSecondaryContainer),
        hintText: TitleConsts.thuchanh,
        hintStyle:
            TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.tertiaryContainer,
        prefixIcon: const Icon(Icons.book_outlined),
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary),
      ),
    );
  }

  _cuoiKyField(context, EditGradeStudentState state) {
    return TextFormField(
      key: const Key('cuoiKy'),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      initialValue: state.cuoiKy.toString(),
      onFieldSubmitted: (value) {
        setState(() {
          _cuoiKy = double.tryParse(value) ?? 0;
        });
      },
      decoration: InputDecoration(
        labelText: TitleConsts.cuoiky,
        labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSecondaryContainer),
        hintText: TitleConsts.cuoiky,
        hintStyle:
            TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.tertiaryContainer,
        prefixIcon: const Icon(Icons.book_outlined),
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
