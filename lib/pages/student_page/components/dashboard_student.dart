// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:qlsvnhom3/constants/image_consts.dart';
import 'package:qlsvnhom3/constants/title_consts.dart';
import 'package:qlsvnhom3/routes.dart';

import '../../../models/student_model/student_model.dart';

class DashboardStudent extends StatelessWidget {
  const DashboardStudent({Key? key, required StudentModel student})
      : _student = student,
        super(key: key);

  final StudentModel _student;

//////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    /////////////////////////////////////////////////////////////////////////////////////
    List<CustomIcon> customIcons = [
      CustomIcon(
        name: TitleConsts.thoikhoabieu,
        icon: ImageConsts.tkb,
        function: () {
          Navigator.pushNamed(context, PAGE_STUDENT_CALENDER,
              arguments: _student.mssv);
        },
      ),
      CustomIcon(
        name: TitleConsts.bangdiem,
        icon: ImageConsts.diemso,
        function: () {
          Navigator.pushNamed(context, PAGE_SCOREBOARD, arguments: _student);
        },
      ),
      CustomIcon(
        name: TitleConsts.lichthi,
        icon: ImageConsts.thi,
        function: () {},
      ),
    ];

///////////////////////////////////////////////////////////////////////////////////////
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(customIcons.length, (index) {
        return Column(
          children: [
            Material(
              elevation: 3.0,
              child: Ink(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(customIcons[index].icon),
                    fit: BoxFit.cover,
                  ),
                ),
                child: InkWell(
                  onTap: customIcons[index].function,
                  splashColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(customIcons[index].name)
          ],
        );
      }),
    );
  }
}

class CustomIcon {
  final String name;
  final String icon;
  final Function() function;

  CustomIcon({
    required this.name,
    required this.icon,
    required this.function,
  });
}
