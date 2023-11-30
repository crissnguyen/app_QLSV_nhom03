part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final auth.User? authUser;
  final UserModel user;

  const AuthUserChanged({
    required this.authUser,
    this.user = UserModel.empty,
  });

  @override
  List<Object?> get props => [authUser, user];
}

class AuthLoginRequested extends AuthEvent {
  final String? email;
  final String? username;
  final String? password;

  const AuthLoginRequested({
    this.email,
    this.username,
    this.password,
  });

  @override
  List<Object?> get props => [email, username, password];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();

  @override
  List<Object?> get props => [];
}
