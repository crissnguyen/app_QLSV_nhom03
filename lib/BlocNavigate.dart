// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlsvnhom3/pages/login_page/login_page.dart';

import 'blocs/auth_bloc/auth_bloc.dart';
import 'routes.dart';

class BlocNavigate extends StatelessWidget {
  static const routeName = BLOC_NAVIGATE;
  const BlocNavigate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print('AuthStatus: ${state.status}');

        if (state.status == AuthStatus.authenticated) {
          final user = state.user;
          if (user.isNotEmpty) {
            if (user.role == 'std') {
              Navigator.pushNamedAndRemoveUntil(
                  context, PAGE_STUDENT, (route) => false);
            } else if (user.role == 'ad') {
              Navigator.pushNamedAndRemoveUntil(
                  context, PAGE_TEACHER, (route) => false);
            }
          }
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
              (route) => false);
        }
      },
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: const LinearProgressIndicator(),
      ),
    );
  }
}
