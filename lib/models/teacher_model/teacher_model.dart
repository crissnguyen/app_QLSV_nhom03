import 'dart:convert';

import 'package:equatable/equatable.dart';

class TeacherModel extends Equatable {
  const TeacherModel({
    required this.maGV,
    this.ten,
    this.lopDay,
  });

  final String maGV;
  final String? ten;
  final List<LopDay>? lopDay;

  static const empty = TeacherModel(maGV: '');
  bool get isEmpty => this == TeacherModel.empty;
  bool get isNotEmpty => this != TeacherModel.empty;

  TeacherModel copyWith({
    String? maGV,
    String? ten,
    List<LopDay>? lopDay,
  }) {
    return TeacherModel(
      maGV: maGV ?? this.maGV,
      ten: ten ?? this.ten,
      lopDay: lopDay ?? this.lopDay,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'maGV': maGV});
    if (ten != null) {
      result.addAll({'ten': ten});
    }
    if (lopDay != null) {
      result.addAll({'lopDay': lopDay!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      maGV: map['maGV'] ?? '',
      ten: map['ten'],
      lopDay: map['lopDay'] != null
          ? List<LopDay>.from(map['lopDay']?.map((x) => LopDay.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherModel.fromJson(String source) =>
      TeacherModel.fromMap(json.decode(source));

  @override
  String toString() => 'TeacherModel(maGV: $maGV, ten: $ten, lopDay: $lopDay)';

  @override
  List<Object?> get props => [maGV, ten, lopDay];
}

class LopDay extends Equatable {
  final String? maLop;
  final String? tenMH;

  const LopDay({
    this.maLop,
    this.tenMH,
  });

  LopDay copyWith({
    String? maLop,
    String? tenMH,
  }) {
    return LopDay(
      maLop: maLop ?? this.maLop,
      tenMH: tenMH ?? this.tenMH,
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

    return result;
  }

  factory LopDay.fromMap(Map<String, dynamic> map) {
    return LopDay(
      maLop: map['maLop'],
      tenMH: map['tenMH'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LopDay.fromJson(String source) => LopDay.fromMap(json.decode(source));

  @override
  String toString() => 'LopDay(maLop: $maLop, tenMH: $tenMH)';

  @override
  List<Object?> get props => [maLop, tenMH];
}
