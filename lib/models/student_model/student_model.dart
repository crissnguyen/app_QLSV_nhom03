// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StudentModel extends Equatable {
  const StudentModel({
    required this.mssv,
    this.ten,
    this.gioiTinh,
    this.ngaySinh,
  });

  final String mssv;
  final String? ten;
  final String? gioiTinh;
  final DateTime? ngaySinh;

  static const empty = StudentModel(mssv: '');
  bool get isEmpty => this == StudentModel.empty;
  bool get isNotEmpty => this != StudentModel.empty;

  @override
  List<Object?> get props => [mssv, ten, gioiTinh, ngaySinh];

  StudentModel copyWith({
    String? mssv,
    String? ten,
    String? gioiTinh,
    DateTime? ngaySinh,
  }) {
    return StudentModel(
      mssv: mssv ?? this.mssv,
      ten: ten ?? this.ten,
      gioiTinh: gioiTinh ?? this.gioiTinh,
      ngaySinh: ngaySinh ?? this.ngaySinh,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'mssv': mssv});
    if (ten != null) {
      result.addAll({'ten': ten});
    }
    if (gioiTinh != null) {
      result.addAll({'gioiTinh': gioiTinh});
    }
    if (ngaySinh != null) {
      result.addAll({'ngaySinh': Timestamp.fromDate(ngaySinh!)});
    }

    return result;
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    final Timestamp ngaySinh = map['ngaySinh'];

    return StudentModel(
      mssv: map['mssv'] ?? '',
      ten: map['ten'],
      gioiTinh: map['gioiTinh'],
      ngaySinh: ngaySinh.toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) =>
      StudentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentModel(mssv: $mssv, ten: $ten, gioiTinh: $gioiTinh, ngaySinh: $ngaySinh)';
  }
}

 // Timestamp.fromDate
 //  _birthDay.toDate()
