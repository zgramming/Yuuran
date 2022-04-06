import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class AccountMenu extends StatelessWidget {
  const AccountMenu({
    Key? key,
    this.onTap,
    this.circleBackgroundColor,
    this.circleForegroundColor,
    required this.icon,
    this.title = '',
    this.subtitle = '',
  }) : super(key: key);

  final void Function()? onTap;
  final Color? circleBackgroundColor;
  final Color? circleForegroundColor;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              color: black.withOpacity(.25),
            ),
          ],
        ),
        // margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: CircleAvatar(
                  backgroundColor: circleBackgroundColor,
                  foregroundColor: circleForegroundColor,
                  child: Icon(icon),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                title,
                style:
                    bFont.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.1, fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                subtitle,
                style: bFont.copyWith(
                  letterSpacing: 1.1,
                  color: grey,
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
