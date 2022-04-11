import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../injection.dart';
import '../login/login_page.dart';
import '../onboarding/onboarding_page.dart';

import '../../../utils/utils.dart';
import '../welcome/welcome_page.dart';

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
              if (appConfig.userSession != null) return const WelcomePage();

              if (appConfig.alreadyOnboarding) return const LoginPage();

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
