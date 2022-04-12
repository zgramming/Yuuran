import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';
import 'widgets/account_menu.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appConfigNotifer).item.userSession;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: secondary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Hello ",
                        children: [
                          TextSpan(
                            text: "${user?.name}",
                            style: hFontWhite.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          )
                        ],
                      ),
                      style: hFontWhite.copyWith(fontSize: 14.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "Halaman Account ini untuk mengatur tentang profile kamu",
                      style: bFontWhite.copyWith(fontWeight: FontWeight.w300, fontSize: 12.0),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              children: [
                AccountMenu(
                  onTap: () {},
                  icon: Icons.settings_applications_outlined,
                  circleBackgroundColor: Colors.lightBlue,
                  circleForegroundColor: Colors.white,
                  title: "Tentang Aplikasi",
                  subtitle: "Informasi lengkap tentang aplikasi Yuuran",
                ),
                AccountMenu(
                  onTap: () async {
                    await ref.read(appConfigNotifer.notifier).deleteUserSession();
                    context.goNamed(loginRouteName);
                  },
                  icon: Icons.logout,
                  circleBackgroundColor: danger,
                  circleForegroundColor: Colors.white,
                  title: "LOGOUT",
                  subtitle: "Keluar aplikasi",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
