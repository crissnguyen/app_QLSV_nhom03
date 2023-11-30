// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ClassModel extends Equatable {
  final String maLop;
  final String? maHP;
  final String? maMH;
  final String? tenMH;
  final String? maPH;
  final String? maCa;
  final String? thu;
  final String? maGV;
  final int? soLuong;
  final DateTime? tgBatDau;
  final DateTime? tgKetThuc;
  final List<DiemDanhSV>? danhSachSV;

  const ClassModel({
    required this.maLop,
    this.maHP,
    this.maMH,
    this.tenMH,
    this.maPH,
    this.maCa,
    this.thu,
    this.maGV,
    this.soLuong,
    this.tgBatDau,
    this.tgKetThuc,
    this.danhSachSV,
  });

  static const empty = ClassModel(maLop: '');
  bool get isEmpty => this == ClassModel.empty;
  bool get isNotEmpty => this != ClassModel.empty;

  ClassModel copyWith({
    String? maLop,
    String? maHP,
    String? maMH,
    String? tenMH,
    String? maPH,
    String? maCa,
    String? thu,
    String? maGV,
    int? soLuong,
    DateTime? tgBatDau,
    DateTime? tgKetThuc,
    List<DiemDanhSV>? danhSachSV,
  }) {
    return ClassModel(
      maLop: maLop ?? this.maLop,
      maHP: maHP ?? this.maHP,
      maMH: maMH ?? this.maMH,
      tenMH: tenMH ?? this.tenMH,
      maPH: maPH ?? this.maPH,
      maCa: maCa ?? this.maCa,
      thu: thu ?? this.thu,
      maGV: maGV ?? this.maGV,
      soLuong: soLuong ?? this.soLuong,
      tgBatDau: tgBatDau ?? this.tgBatDau,
      tgKetThuc: tgKetThuc ?? this.tgKetThuc,
      danhSachSV: danhSachSV ?? this.danhSachSV,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'maLop': maLop});
    if (maHP != null) {
      result.addAll({'maHP': maHP});
    }
    if (maMH != null) {
      result.addAll({'maMH': maMH});
    }
    if (tenMH != null) {
      result.addAll({'tenMH': tenMH});
    }
    if (maPH != null) {
      result.addAll({'maPH': maPH});
    }
    if (maCa != null) {
      result.addAll({'maCa': maCa});
    }
    if (thu != null) {
      result.addAll({'thu': thu});
    }
    if (maGV != null) {
      result.addAll({'maGV': maGV});
    }
    if (soLuong != null) {
      result.addAll({'soLuong': soLuong});
    }
    if (tgBatDau != null) {
      result.addAll({'tgBatDau': Timestamp.fromDate(tgBatDau!)});
    }
    if (tgKetThuc != null) {
      result.addAll({'tgKetThuc': Timestamp.fromDate(tgKetThuc!)});
    }
    if (danhSachSV != null) {
      result.addAll({'danhSachSV': danhSachSV!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    final Timestamp _tgBatDau = map['tgBatDau'];
    final Timestamp _tgKetThuc = map['tgKetThuc'];

    return ClassModel(
      maLop: map['maLop'] ?? '',
      maHP: map['maHP'],
      maMH: map['maMH'],
      tenMH: map['tenMH'],
      maPH: map['maPH'],
      maCa: map['maCa'],
      thu: map['thu'],
      maGV: map['maGV'],
      soLuong: map['soLuong']?.toInt(),
      tgBatDau: _tgBatDau.toDate(),
      tgKetThuc: _tgKetThuc.toDate(),
      danhSachSV: map['danhSachSV'] != null
          ? List<DiemDanhSV>.from(
              map['danhSachSV']?.map((x) => DiemDanhSV.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassModel.fromJson(String source) =>
      ClassModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClassModel(maLop: $maLop, maHP: $maHP, maMH: $maMH, tenMH: $tenMH, maPH: $maPH, maCa: $maCa, thu: $thu, maGV: $maGV, soLuong: $soLuong, tgBatDau: $tgBatDau, tgKetThuc: $tgKetThuc, danhSachSV: $danhSachSV)';
  }

  @override
  List<Object?> get props {
    return [
      maLop,
      maHP,
      maMH,
      tenMH,
      maPH,
      maCa,
      thu,
      maGV,
      soLuong,
      tgBatDau,
      tgKetThuc,
      danhSachSV,
    ];
  }
}

class DiemDanhSV extends Equatable {
  final String? mssv;
  final String? tenSV;
  final int? slDiemDanh;
  const DiemDanhSV({
    this.mssv,
    this.tenSV,
    this.slDiemDanh,
  });

  DiemDanhSV copyWith({
    String? mssv,
    String? tenSV,
    int? slDiemDanh,
  }) {
    return DiemDanhSV(
      mssv: mssv ?? this.mssv,
      tenSV: tenSV ?? this.tenSV,
      slDiemDanh: slDiemDanh ?? this.slDiemDanh,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (mssv != null) {
      result.addAll({'mssv': mssv});
    }
    if (tenSV != null) {
      result.addAll({'tenSV': tenSV});
    }
    if (slDiemDanh != null) {
      result.addAll({'slDiemDanh': slDiemDanh});
    }

    return result;
  }

  factory DiemDanhSV.fromMap(Map<String, dynamic> map) {
    return DiemDanhSV(
      mssv: map['mssv'],
      tenSV: map['tenSV'],
      slDiemDanh: map['slDiemDanh']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiemDanhSV.fromJson(String source) =>
      DiemDanhSV.fromMap(json.decode(source));

  @override
  String toString() =>
      'DiemDanhSV(mssv: $mssv, tenSV: $tenSV, slDiemDanh: $slDiemDanh)';

  @override
  List<Object?> get props => [mssv, tenSV, slDiemDanh];
}
