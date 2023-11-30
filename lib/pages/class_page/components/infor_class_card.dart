// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'package:qlsvnhom3/constants/title_consts.dart';

class InforClassCard extends StatelessWidget {
  const InforClassCard({
    Key? key,
    this.tenMH,
    this.maPH,
    this.maCa,
    this.thu,
    this.tgBatDau,
    this.tgKetThuc,
    this.soluong,
  }) : super(key: key);

  final String? tenMH;
  final String? maPH;
  final String? maCa;
  final String? thu;
  final DateTime? tgBatDau;
  final DateTime? tgKetThuc;
  final int? soluong;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 150,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextClassCard(
            title: TitleConsts.tenMH,
            subTitle: tenMH ?? '',
          ),
          Row(
            children: [
              TextClassCard(
                title: TitleConsts.maPH,
                subTitle: maPH ?? '',
              ),
              const Text(' - '),
              TextClassCard(
                title: TitleConsts.maCa,
                subTitle: maCa ?? '',
              ),
            ],
          ),
          TextClassCard(
            title: TitleConsts.thoigianhoc,
            subTitle: "${thu ?? ''} " +
                "${TitleConsts.tu} ${tgBatDau?.day ?? 0}/${tgBatDau?.month ?? 0}/${tgBatDau?.year ?? 0} - " +
                "${tgKetThuc?.day ?? 0}/${tgKetThuc?.month ?? 0}/${tgKetThuc?.year ?? 0}",
          ),
        ],
      ),
    );
  }
}

class TextClassCard extends StatelessWidget {
  const TextClassCard({
    Key? key,
    this.title,
    this.subTitle,
  }) : super(key: key);

  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            "${title ?? ''}: ",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          subTitle ?? '',
          maxLines: 2,
          softWrap: true,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
  }
}
