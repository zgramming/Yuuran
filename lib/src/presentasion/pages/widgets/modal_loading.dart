import 'package:flutter/material.dart';

class ModalLoadingWidget extends StatelessWidget {
  const ModalLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        content: Builder(builder: (context) {
          return Container(
            width: 300,
            height: 300,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
