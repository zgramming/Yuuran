import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/model/app_config/app_config_model.dart';
import '../presentasion/pages/citizen_dues/citizen_dues_page.dart';
import '../presentasion/pages/citizen_form/citizen_form_page.dart';
import '../presentasion/pages/dues_category/dues_category_page.dart';
import '../presentasion/pages/dues_category_form/dues_category_form_page.dart';
import '../presentasion/pages/dues_form/dues_form_page.dart';
import '../presentasion/pages/login/login_page.dart';
import '../presentasion/pages/onboarding/onboarding_page.dart';
import '../presentasion/pages/welcome/welcome_page.dart';
import '../presentasion/riverpod/app_config/app_config_notifier.dart';

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
      initialLocation: "/onboarding",
      refreshListenable: GoRouterNotifier(ref: ref),
      redirect: (state) {
        final appConfig = ref.read(appConfigNotifer).itemAsync.value!;

        final alreadyOnboarding = appConfig.alreadyOnboarding;
        final user = appConfig.userSession;

        final isAtLoginPage = state.location == '/login';
        final isAtOnboardingPage = state.location == "/onboarding";

        /// Skenario Redirect Go Router
        /// Default location is [/onboarding]
        ///
        /// 1. Check apakah user sudah pernah onboarding / belum
        ///   1.1. Jika belum pernah, check apakah sekarang sedang di halaman [/onboarding]
        ///     1.1.1. Jika tidak berada di [/onboarding], lempar ke halaman [/onboarding]
        ///     1.1.2. Jika berada di [/onboarding], return [null]
        ///
        ///
        /// 2. Check apakah user belum pernah login
        ///   2.1. Jika belum pernah, check apakah sekarang sedang di halaman [/login]
        ///     2.1.1. Jika tidak berada di [/login], lempar ke halaman [/login]
        ///     2.1.2. Jika berada di [/login], return [null]
        ///
        ///
        /// Kondisi ke [3] sudah dipastikan kalau user sudah pernah login
        /// Karena kita sudah melewati kondisi ke [2].
        /// Kita hanya tinggal mengecek apakah user yang sudah login, berada di [/login] atau [/onboarding]
        /// Jika berada di halaman tersebut, lempar user ke halaman [/]
        ///
        ///
        /// 3. Check apakah user yang sudah login berada di [/login] atau [/onboarding]
        ///   3.1. Jika berada di antara [/login] atau [/onboarding], lempar ke halaman [/]
        ///
        ///   3.2. Jika tidak berada di antara [/login] atau [/onboarding], return [null]
        ///
        ///

        /// Kondisi [1]
        if (!alreadyOnboarding) return isAtOnboardingPage ? null : "/onboarding";

        /// Kondisi [2]
        if (user?.id == null) return isAtLoginPage ? null : "/login";

        /// Kondisi [3]
        if (isAtOnboardingPage || isAtLoginPage) return "/";

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

            return DuesFormPage(duesDetailID: params['duesDetailID'] ?? "");
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
                final duesCategoryId = param['duesCategoryID'];
                return DuesCategoryFormPage(duesCategoryID: int.parse(duesCategoryId ?? "0"));
              },
            ),
          ],
        ),
        GoRoute(
          path: "/citizen/dues/:username",
          name: citizenDuesRouteName,
          builder: (ctx, state) {
            final params = state.params;
            return CitizenDuesPage(username: params['username'] ?? '0');
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

/// This class will trigger [notifyListeners] when user data has change
/// When trigger, [go_router] configuration will be refreshed and check for redirect
/// This scenario usefull when user has login and we should throw user to [welcome_page]
/// When user logout and back to application, we should throw user to [login_page] when force to another page
class GoRouterNotifier extends ChangeNotifier {
  final Ref ref;
  GoRouterNotifier({required this.ref}) {
    ref.listen<AppConfigModel>(
      appConfigNotifer.select((value) => value.itemAsync.value!),
      (_, __) => notifyListeners(),
    );
  }
}
