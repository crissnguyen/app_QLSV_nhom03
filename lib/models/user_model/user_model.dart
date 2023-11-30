import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.uid,
    this.email,
    this.password,
    this.username,
    this.role,
  });

  final String uid;
  final String? email;
  final String? password;
  final String? username;
  final String? role;

  /// Empty user which represents an unauthenticated user.
  static const empty = UserModel(uid: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserModel.empty;

  UserModel copyWith({
    String? uid,
    String? email,
    String? password,
    String? username,
    String? role,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [uid, email, password, username, role];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    if (email != null) {
      result.addAll({'email': email});
    }
    if (password != null) {
      result.addAll({'password': password});
    }
    if (username != null) {
      result.addAll({'username': username});
    }
    if (role != null) {
      result.addAll({'role': role});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'],
      password: map['password'],
      username: map['username'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
