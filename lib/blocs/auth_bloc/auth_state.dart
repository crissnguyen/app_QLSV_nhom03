part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final auth.User? authUser;
  final UserModel user;
  final String? errorMessage;

  const AuthState._({
    this.status = AuthStatus.unknown,
    this.authUser,
    this.user = UserModel.empty,
    this.errorMessage,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated({
    required auth.User authUser,
    required UserModel user,
  }) : this._(
          status: AuthStatus.authenticated,
          authUser: authUser,
          user: user,
        );

  const AuthState.unauthenticated()
      : this._(
          status: AuthStatus.unauthenticated,
        );

  const AuthState.failure({
    required String errorMessage,
  }) : this._(
          status: AuthStatus.failure,
          errorMessage: errorMessage,
        );

  @override
  List<Object?> get props => [status, authUser, user, errorMessage];
}
