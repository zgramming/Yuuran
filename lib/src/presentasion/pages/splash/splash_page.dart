import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yuuran/src/presentasion/pages/login/login_page.dart';
import 'package:yuuran/src/presentasion/pages/onboarding/onboarding_page.dart';
import 'package:yuuran/src/presentasion/riverpod/app_config/app_config_notifier.dart';

import '../../../utils/utils.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Consumer(
        builder: (context, ref, child) {
          final _init = ref.watch(appConfigInitialize);
          return _init.when(
            data: (appConfig) {
              if (appConfig.alreadyOnboarding) {
                return const LoginPage();
              }
              return const OnboardingPage();
            },
            error: (error, stackTrace) => Center(child: Text("Error $error")),
            loading: () {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Colors.white),
                    const SizedBox(height: 10),
                    Text("Tunggu sebentar ya...", style: bFont.copyWith(color: Colors.white)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
