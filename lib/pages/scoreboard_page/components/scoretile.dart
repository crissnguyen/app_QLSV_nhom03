import 'package:flutter/material.dart';

import 'package:qlsvnhom3/constants/title_consts.dart';

class ScoreTile extends StatelessWidget {
  const ScoreTile({
    Key? key,
    required this.tenMH,
    required this.lyThuyet,
    required this.thucHanh,
    required this.cuoiKy,
  }) : super(key: key);

  final String tenMH;
  final double lyThuyet;
  final double thucHanh;
  final double cuoiKy;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.book_outlined),
      title: Text(
        tenMH,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      subtitle: Text(
          '${TitleConsts.lythuyet}: $lyThuyet | ${TitleConsts.thuchanh}: $thucHanh | ${TitleConsts.cuoiky}: $cuoiKy'),
    );
  }
}
