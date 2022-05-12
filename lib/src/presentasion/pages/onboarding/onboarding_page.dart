import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../utils/utils.dart';
import '../../riverpod/app_config/app_config_action_notifier.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _decoration = PageDecoration(
    titleTextStyle: hFontWhite.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 28.0,
    ),
    bodyTextStyle: bFontWhite.copyWith(
      fontSize: 12.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: primary,
      pages: [
        PageViewModel(
          image: Center(
            child: Image.asset(
              pathOnboarding1,
              fit: BoxFit.cover,
              width: sharedFunction.vw(context) / 2,
            ),
          ),
          title: "Permudah Pencatatan",
          body: "Tidak perlu membawa buku kemana-mana lagi untuk pencatatan iuran",
          decoration: _decoration,
        ),
        PageViewModel(
          image: Center(
            child: Image.asset(
              pathOnboarding2,
              fit: BoxFit.cover,
              width: sharedFunction.vw(context) / 2,
            ),
          ),
          title: "Permudah Pemantauan",
          body: "Lebih mudah untuk memantau warga yang sudah bayar iuran atau belum",
          decoration: _decoration,
        ),
        PageViewModel(
          image: Center(
            child: Image.asset(
              pathOnboarding3,
              fit: BoxFit.cover,
              width: sharedFunction.vw(context) / 2,
            ),
          ),
          title: "Permudah Laporan",
          body: "Keluar masuk iuran pun lebih transparan dan mudah untuk dibuatkan laporannya",
          decoration: _decoration,
        ),
        PageViewModel(
          image: Center(
            child: Image.asset(
              pathOnboarding4,
              fit: BoxFit.cover,
              width: sharedFunction.vw(context) / 2,
            ),
          ),
          title: "Warga Senang Kamu Senang",
          body: '',
          decoration: _decoration,
        ),
      ],
      done: Text("Selesai", style: bFontWhite.copyWith(fontWeight: FontWeight.bold)),
      next: Text("Lanjut", style: bFontWhite),
      onDone: () async {
        await ref.read(appConfigActionNotifier.notifier).setOnboarding(true);
        context.goNamed(loginRouteName);
      },
    );
  }
}
