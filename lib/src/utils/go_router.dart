import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../injection.dart';
import '../data/model/user/user_model.dart';
import '../presentasion/pages/citizen_dues/citizen_dues_page.dart';
import '../presentasion/pages/citizen_form/citizen_form_page.dart';
import '../presentasion/pages/dues_category/dues_category_page.dart';
import '../presentasion/pages/dues_category_form/dues_category_form_page.dart';
import '../presentasion/pages/dues_form/dues_form_page.dart';
import '../presentasion/pages/login/login_page.dart';
import '../presentasion/pages/onboarding/onboarding_page.dart';
import '../presentasion/pages/welcome/welcome_page.dart';

const splashRouteName = "splash";
const onboardingRouteName = "onboarding";
const loginRouteName = "login";
const welcomeRouteName = "welcome";

const duesFormRouteName = "duesForm";
const duesCategoryRouteName = "duesCategory";
const duesCategoryFormRouteName = "duesCategoryForm";

const citizenDuesRouteName = "citizenDues";
const citizenFormRouteName = "citizenForm";
const citizenProfileRouteName = "citizenProfile";

const myProfileRouteName = "myProfile";

final goRouter = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      debugLogDiagnostics: true,
      // initialLocation: "/",
      refreshListenable: GoRouterNotifier(ref: ref),
      redirect: (state) {
        final appConfig = ref.read(appConfigNotifer).item;
        final alreadyOnboarding = appConfig.alreadyOnboarding;
        final user = appConfig.userSession;
        final isAtLoginPage = state.location == '/login';

        /// Jika belum pernah masuk onboarding
        /// Kita lempar kehalaman onboarding
        if (!alreadyOnboarding) return "/onboarding";

        /// Check apakah user == null
        /// Jika Null check kembali, apakah dihalaman login / tidak
        /// Jika dihalaman login return null
        /// Jika tidak dihalaman login lempar kehalaman login
        if (user?.id == null) {
          return isAtLoginPage ? null : "/login";
        }

        /// Jika kita sudah login tetapi kita di halaman login
        /// Kita lempar ke halaman welcome
        if (isAtLoginPage) return "/";

        return null;
      },
      routes: [
        GoRoute(
          path: "/",
          name: welcomeRouteName,
          builder: (ctx, state) => const WelcomePage(),
        ),
        GoRoute(
          path: "/onboarding",
          name: onboardingRouteName,
          builder: (ctx, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: "/login",
          name: loginRouteName,
          builder: (ctx, state) => const LoginPage(),
        ),
        GoRoute(
          path: "/dues/form/:duesDetailID",
          name: duesFormRouteName,
          builder: (ctx, state) {
            final params = state.params;

            return DuesFormPage(
              duesDetailID: params['duesDetailID'] ?? "",
            );
          },
        ),
        GoRoute(
          path: "/dues/category",
          name: duesCategoryRouteName,
          builder: (ctx, state) => const DuesCategoryPage(),
          routes: [
            /// [/dues/category/form/code-category]
            GoRoute(
              path: "form/:duesCategoryID",
              name: duesCategoryFormRouteName,
              builder: (ctx, state) {
                final param = state.params;
                return DuesCategoryFormPage(
                  duesCategoryID: param['duesCategoryID'] ?? "0",
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: "/citizen/dues/:username",
          name: citizenDuesRouteName,
          builder: (ctx, state) {
            final params = state.params;
            return CitizenDuesPage(
              username: params['username'] ?? '0',
            );
          },
        ),
        GoRoute(
          path: "/citizen/form/:id",
          name: citizenFormRouteName,
          builder: (ctx, state) {
            final params = state.params;
            final id = int.parse(params['id'] ?? "0");
            return CitizenFormPage(id: id);
          },
        ),
      ],
    );
  },
);

class GoRouterNotifier extends ChangeNotifier {
  final Ref ref;
  GoRouterNotifier({required this.ref}) {
    ref.listen<UserModel?>(
      appConfigNotifer.select((value) => value.item.userSession),
      (_, __) => notifyListeners(),
    );
  }
}
