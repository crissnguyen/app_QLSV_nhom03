import 'package:flutter/material.dart';

import 'package:qlsvnhom3/constants/title_consts.dart';
import 'package:qlsvnhom3/models/class_model/class_model.dart';
import 'package:qlsvnhom3/pages/edit_grade_student_form/edit_grade_student_form.dart';

class StudentClassList extends StatelessWidget {
  const StudentClassList({
    Key? key,
    required this.maLop,
    required this.danhSachSV,
  }) : super(key: key);

  final String maLop;
  final List<DiemDanhSV> danhSachSV;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: danhSachSV.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
              "${danhSachSV[index].tenSV ?? ''} (${danhSachSV[index].mssv})"),
          subtitle: Text(
              " ${TitleConsts.solanDiemDanh}: ${danhSachSV[index].slDiemDanh ?? 0}"),
          onTap: () {
            showModalBottomSheet<Form>(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return EditGradeStudentForm(
                  mssv: danhSachSV[index].mssv ?? '',
                  maLop: maLop,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
