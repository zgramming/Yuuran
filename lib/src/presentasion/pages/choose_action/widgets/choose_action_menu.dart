import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class ChooseActionMenu extends StatelessWidget {
  const ChooseActionMenu({
    Key? key,
    this.title = '',
    this.subtitle = '',
    this.circleBackgroudColor,
    this.circleForegroundColor,
    required this.iconData,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Color? circleBackgroudColor;
  final Color? circleForegroundColor;
  final IconData iconData;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: CircleAvatar(
          backgroundColor: circleBackgroudColor ?? primary,
          foregroundColor: circleForegroundColor ?? Colors.white,
          child: Icon(iconData),
        ),
        title: Text(
          title,
          style: hFont.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: bFont.copyWith(fontSize: 10.0, color: grey),
        ),
      ),
    );
  }
}
