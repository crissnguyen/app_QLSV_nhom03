import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final Function() onTap;
  final Color color;
  final IconData icon;
  final String text;
  const ListCard({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.8),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: color,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, size: 32),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ])),
    );
  }
}
