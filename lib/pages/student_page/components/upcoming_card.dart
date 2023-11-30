import 'package:flutter/material.dart';
import 'package:qlsvnhom3/constants/image_consts.dart';
import 'package:qlsvnhom3/constants/title_consts.dart';

class UpcomingCard extends StatelessWidget {
  const UpcomingCard({
    Key? key,
    required this.fullname,
    required this.mssv,
    required this.gender,
  }) : super(key: key);

  final String fullname;
  final String mssv;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 150,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              gender.isNotEmpty
                  ? gender == 'male'
                      ? ImageConsts.boy
                      : ImageConsts.girl
                  : ImageConsts.boy,
              width: 45,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullname,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${TitleConsts.mssv}: $mssv",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 18),
            ],
          )
        ],
      ),
    );
  }
}
