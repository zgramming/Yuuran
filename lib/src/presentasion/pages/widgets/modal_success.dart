import 'package:flutter/material.dart';

import '../../../utils/fonts.dart';

class ModalSuccessWidget extends StatelessWidget {
  const ModalSuccessWidget({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Icon(
              Icons.check_outlined,
              color: Colors.white,
              size: 40.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Center(child: Text(message, style: bFontWhite.copyWith(fontSize: 16.0))),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
