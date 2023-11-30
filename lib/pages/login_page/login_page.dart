// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qlsvnhom3/blocs/auth_bloc/auth_bloc.dart';
import 'package:qlsvnhom3/constants/image_consts.dart';
import 'package:qlsvnhom3/constants/title_consts.dart';
import 'package:qlsvnhom3/pages/widgets/snack_processdata.dart';
import 'package:qlsvnhom3/utils/validator.dart';
import 'package:qlsvnhom3/routes.dart';

class LoginPage extends StatefulWidget {
  static const routeName = PAGE_LOGIN;
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailEditingController;
  late TextEditingController passEditingController;

  @override
  void initState() {
    super.initState();

    emailEditingController = TextEditingController();
    passEditingController = TextEditingController();
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print('loginStatus: ${state.status}');

        if (state.status == AuthStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? '')),
          );
        }
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
        }
      },
      builder: (context, state) {
        return loginBody(context);
      },
    );
  }

  submitLogin(BuildContext context) async {
    final email = emailEditingController.text;
    final pass = passEditingController.text;

    if (email.isNotEmpty && pass.isNotEmpty) {
      context
          .read<AuthBloc>()
          .add(AuthLoginRequested(email: email, password: pass));
    }
  }

  loginBody(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.inversePrimary
              ]),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.030),
            child: _loginForm(context, size),
          ),
        ),
      ),
    );
  }

  _loginForm(context, size) {
    return Form(
      key: _formKey,
      child: OverflowBar(
        overflowAlignment: OverflowBarAlignment.center,
        overflowSpacing: size.height * 0.014,
        children: [
          Image.asset(ImageConsts.mascot),
          const Text(
            TitleConsts.welcome,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const Text(
            TitleConsts.qlsvFull,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
          SizedBox(height: size.height * 0.024),
          _emailField(context),
          _passField(context),
          _loginButton(context, size),
          SizedBox(height: size.height * 0.014),
        ],
      ),
    );
  }

  _emailField(context) {
    return TextFormField(
      key: const ValueKey('email'),
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (email) => Validator.validateEmail(email: email ?? ''),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
        filled: true,
        hintText: TitleConsts.email,
        prefixIcon: const Icon(Icons.email_outlined),
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(37),
        ),
      ),
    );
  }

  _passField(context) {
    return TextFormField(
      key: const ValueKey('password'),
      controller: passEditingController,
      obscureText: true,
      keyboardType: TextInputType.text,
      validator: (password) =>
          Validator.validatePassword(password: password ?? ''),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
        filled: true,
        hintText: TitleConsts.pass,
        prefixIcon: const Icon(Icons.password_outlined),
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(37),
        ),
      ),
    );
  }

  _loginButton(context, size) {
    return ElevatedButton(
      onPressed: () {
        final bool _isValidate = _formKey.currentState?.validate() ?? false;

        setState(() {
          if (_isValidate == true) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            snackProcessData(context);

            submitLogin(context);
          } else if (_isValidate == false) {}
        });
      },
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        minimumSize: Size(double.infinity, size.height * 0.080),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(37)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Text(
        TitleConsts.dangnhap,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
