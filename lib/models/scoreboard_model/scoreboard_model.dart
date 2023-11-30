// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

class ScoreBoardModel extends Equatable {
  const ScoreBoardModel({
    required this.mssv,
    this.uid,
    this.data,
  });

  final String mssv;
  final String? uid;
  final List<DiemMH>? data;

  static const empty = ScoreBoardModel(mssv: '');
  bool get isEmpty => this == ScoreBoardModel.empty;
  bool get isNotEmpty => this != ScoreBoardModel.empty;

  ScoreBoardModel copyWith({
    String? mssv,
    String? uid,
    List<DiemMH>? data,
  }) {
    return ScoreBoardModel(
      mssv: mssv ?? this.mssv,
      uid: uid ?? this.uid,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'mssv': mssv});
    if (uid != null) {
      result.addAll({'uid': uid});
    }
    if (data != null) {
      result.addAll({'data': data!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory ScoreBoardModel.fromMap(Map<String, dynamic> map) {
    return ScoreBoardModel(
      mssv: map['mssv'] ?? '',
      uid: map['uid'],
      data: map['data'] != null
          ? List<DiemMH>.from(map['data']?.map((x) => DiemMH.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScoreBoardModel.fromJson(String source) =>
      ScoreBoardModel.fromMap(json.decode(source));

  @override
  String toString() => 'ScoreBoardModel(mssv: $mssv, uid: $uid, data: $data)';

  @override
  List<Object?> get props => [mssv, uid, data];
}

class DiemMH extends Equatable {
  final String maLop;
  final String? maMH;
  final String? tenMH;
  final double? lyThuyet;
  final double? thucHanh;
  final double? cuoiKy;

  const DiemMH({
    required this.maLop,
    this.maMH,
    this.tenMH,
    this.lyThuyet,
    this.thucHanh,
    this.cuoiKy,
  });

  static const empty = DiemMH(maLop: '');
  bool get isEmpty => this == DiemMH.empty;
  bool get isNotEmpty => this != DiemMH.empty;

  DiemMH copyWith({
    String? maLop,
    String? maMH,
    String? tenMH,
    double? lyThuyet,
    double? thucHanh,
    double? cuoiKy,
  }) {
    return DiemMH(
      maLop: maLop ?? this.maLop,
      maMH: maMH ?? this.maMH,
      tenMH: tenMH ?? this.tenMH,
      lyThuyet: lyThuyet ?? this.lyThuyet,
      thucHanh: thucHanh ?? this.thucHanh,
      cuoiKy: cuoiKy ?? this.cuoiKy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'maLop': maLop});
    if (maMH != null) {
      result.addAll({'maMH': maMH});
    }
    if (tenMH != null) {
      result.addAll({'tenMH': tenMH});
    }
    if (lyThuyet != null) {
      result.addAll({'lyThuyet': lyThuyet});
    }
    if (thucHanh != null) {
      result.addAll({'thucHanh': thucHanh});
    }
    if (cuoiKy != null) {
      result.addAll({'cuoiKy': cuoiKy});
    }

    return result;
  }

  factory DiemMH.fromMap(Map<String, dynamic> map) {
    return DiemMH(
      maLop: map['maLop'] ?? '',
      maMH: map['maMH'],
      tenMH: map['tenMH'],
      lyThuyet: map['lyThuyet']?.toDouble(),
      thucHanh: map['thucHanh']?.toDouble(),
      cuoiKy: map['cuoiKy']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiemMH.fromJson(String source) => DiemMH.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DiemMH(maLop: $maLop, maMH: $maMH, tenMH: $tenMH, lyThuyet: $lyThuyet, thucHanh: $thucHanh, cuoiKy: $cuoiKy)';
  }

  @override
  List<Object?> get props {
    return [
      maLop,
      maMH,
      tenMH,
      lyThuyet,
      thucHanh,
      cuoiKy,
    ];
  }
}
