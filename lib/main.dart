import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlsvnhom3/blocs/auth_bloc/auth_bloc.dart';
import 'package:qlsvnhom3/constants/theme_consts.dart';
import 'package:qlsvnhom3/constants/title_consts.dart';
import 'package:qlsvnhom3/repositories/auth_repository/auth_repository.dart';
import 'package:qlsvnhom3/repositories/user_repository/user_repository.dart';
import 'package:qlsvnhom3/routes.dart';
import 'utils/bloc_observer.dart';
import 'utils/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  // Ideal time to initialize
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  Bloc.observer = const AppBlocObserver();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(
        create: (context) => AuthRepository(),
      ),
      RepositoryProvider(
        create: (context) => UserRepository(),
      ),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
      ],
      child: const App(),
    ),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TitleConsts.qlsv,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeConsts.lightTheme,
      darkTheme: ThemeConsts.darkTheme,
      initialRoute: BLOC_NAVIGATE,
      routes: materialRoutes,
    );
  }
}
