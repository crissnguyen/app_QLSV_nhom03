// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StudentCalenderModel extends Equatable {
  final String uid;
  final String? mssv;
  final List<LichMonHoc>? danhsach;

  const StudentCalenderModel({
    required this.uid,
    this.mssv,
    this.danhsach,
  });

  static const empty = StudentCalenderModel(uid: '');
  bool get isEmpty => this == StudentCalenderModel.empty;
  bool get isNotEmpty => this != StudentCalenderModel.empty;

  StudentCalenderModel copyWith({
    String? uid,
    String? mssv,
    List<LichMonHoc>? danhsach,
  }) {
    return StudentCalenderModel(
      uid: uid ?? this.uid,
      mssv: mssv ?? this.mssv,
      danhsach: danhsach ?? this.danhsach,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    if (mssv != null) {
      result.addAll({'mssv': mssv});
    }
    if (danhsach != null) {
      result.addAll({'danhsach': danhsach!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory StudentCalenderModel.fromMap(Map<String, dynamic> map) {
    return StudentCalenderModel(
      uid: map['uid'] ?? '',
      mssv: map['mssv'],
      danhsach: map['danhsach'] != null
          ? List<LichMonHoc>.from(
              map['danhsach']?.map((x) => LichMonHoc.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentCalenderModel.fromJson(String source) =>
      StudentCalenderModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'StudentcalenderModel(uid: $uid, mssv: $mssv, danhsach: $danhsach)';

  @override
  List<Object?> get props => [uid, mssv, danhsach];
}

class LichMonHoc extends Equatable {
  String? maLop;
  String? tenMH;
  List<LichHoc>? lichHoc;

  LichMonHoc({
    this.maLop,
    this.tenMH,
    this.lichHoc,
  });

  LichMonHoc copyWith({
    String? maLop,
    String? tenMH,
    List<LichHoc>? lichHoc,
  }) {
    return LichMonHoc(
      maLop: maLop ?? this.maLop,
      tenMH: tenMH ?? this.tenMH,
      lichHoc: lichHoc ?? this.lichHoc,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (maLop != null) {
      result.addAll({'maLop': maLop});
    }
    if (tenMH != null) {
      result.addAll({'tenMH': tenMH});
    }
    if (lichHoc != null) {
      result.addAll({'lichHoc': lichHoc!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory LichMonHoc.fromMap(Map<String, dynamic> map) {
    return LichMonHoc(
      maLop: map['maLop'],
      tenMH: map['tenMH'],
      lichHoc: map['lichHoc'] != null
          ? List<LichHoc>.from(map['lichHoc']?.map((x) => LichHoc.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LichMonHoc.fromJson(String source) =>
      LichMonHoc.fromMap(json.decode(source));

  @override
  String toString() =>
      'Danhsach(maLop: $maLop, tenMH: $tenMH, lichHoc: $lichHoc)';

  @override
  List<Object?> get props => [maLop, tenMH, lichHoc];
}

class LichHoc extends Equatable {
  bool? coHoc;
  bool? daDiemDanh;
  DateTime? tgHoc;

  LichHoc({
    this.coHoc,
    this.daDiemDanh,
    this.tgHoc,
  });

  LichHoc copyWith({
    bool? coHoc,
    bool? daDiemDanh,
    DateTime? tgHoc,
  }) {
    return LichHoc(
      coHoc: coHoc ?? this.coHoc,
      daDiemDanh: daDiemDanh ?? this.daDiemDanh,
      tgHoc: tgHoc ?? this.tgHoc,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (coHoc != null) {
      result.addAll({'coHoc': coHoc});
    }
    if (daDiemDanh != null) {
      result.addAll({'daDiemDanh': daDiemDanh});
    }
    if (tgHoc != null) {
      result.addAll({'tgHoc': Timestamp.fromDate(tgHoc!)});
    }

    return result;
  }

  factory LichHoc.fromMap(Map<String, dynamic> map) {
    final Timestamp _tgHoc = map['tgHoc'];

    return LichHoc(
      coHoc: map['coHoc'],
      daDiemDanh: map['daDiemDanh'],
      tgHoc: map['tgHoc'] != null ? _tgHoc.toDate() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LichHoc.fromJson(String source) =>
      LichHoc.fromMap(json.decode(source));

  @override
  String toString() =>
      'LichHoc(coHoc: $coHoc, daDiemDanh: $daDiemDanh, tgHoc: $tgHoc)';

  @override
  List<Object?> get props => [coHoc, daDiemDanh, tgHoc];
}
