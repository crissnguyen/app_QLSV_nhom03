// ignore_for_file: unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../models/user_model/user_model.dart';
import '../../repositories/auth_repository/auth_repository.dart';
import '../../repositories/user_repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<AuthUserChanged>(_onAuthUserChanged);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);

    _authUserSubscription = _authRepository.authUser.listen((authUser) {
      print('AuthUser: $authUser');
      if (authUser != null) {
        _userRepository.getUser(authUser.uid).then(
              (user) => add(AuthUserChanged(authUser: authUser, user: user)),
            );
      } else {
        add(AuthUserChanged(authUser: authUser));
      }
    });
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  late final StreamSubscription<auth.User?> _authUserSubscription;
  late final StreamSubscription<UserModel> _userSubscription;

  Future<void> _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    event.authUser != null
        ? emit(AuthState.authenticated(
            authUser: event.authUser!, user: event.user))
        : emit(const AuthState.unauthenticated());
  }

  FutureOr<void> _onAuthLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    if (event.email != null && event.password != null) {
      try {
        await _authRepository.logInWithEmailAndPassword(
            email: event.email!, password: event.password!);
      } on LogInWithEmailAndPasswordFailure catch (e) {
        emit(AuthState.failure(errorMessage: e.message));
        emit(const AuthState.unauthenticated());
      } catch (_) {
        emit(const AuthState.unauthenticated());
      }
    }
  }

  FutureOr<void> _onAuthLogoutRequested(event, Emitter<AuthState> emit) async {
    unawaited(_authRepository.logOut());
    emit(const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _authUserSubscription.cancel();
    _userSubscription.cancel();
    return super.close();
  }
}
