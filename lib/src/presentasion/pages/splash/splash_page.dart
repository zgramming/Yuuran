import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initialize().then((_) {
      context.goNamed(onboardingRouteName);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 10),
            Text("Tunggu sebentar ya...", style: bFont.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
