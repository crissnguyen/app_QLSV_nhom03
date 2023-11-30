import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qlsvnhom3/pages/login_page/login_page.dart';

class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _LoginState();
}

class _LoginState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(37),
        ),
        child: const Text(
          "Log Out",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      onPressed: () async {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false);
      },
    ));
  }
}
