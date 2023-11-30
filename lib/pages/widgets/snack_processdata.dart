import 'package:flutter/material.dart';
import 'package:qlsvnhom3/constants/title_consts.dart';

Future<void> snackProcessData(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text(TitleConsts.processData)),
  );
}
