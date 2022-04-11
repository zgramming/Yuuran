import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentasion/pages/citizen_dues/citizen_dues_page.dart';
import '../presentasion/pages/citizen_form/citizen_form_page.dart';
import '../presentasion/pages/dues_category/dues_category_page.dart';
import '../presentasion/pages/dues_category_form/dues_category_form_page.dart';
import '../presentasion/pages/dues_form/dues_form_page.dart';
import '../presentasion/pages/login/login_page.dart';
import '../presentasion/pages/onboarding/onboarding_page.dart';
import '../presentasion/pages/splash/splash_page.dart';
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
  (ref) => GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/",
    redirect: (state) {
      return null;
    },
    routes: [
      GoRoute(
        path: "/",
        name: splashRouteName,
        builder: (ctx, state) => const SplashPage(),
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
        path: "/welcome",
        name: welcomeRouteName,
        builder: (ctx, state) => const WelcomePage(),
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
        path: "/citizen/form/:username",
        name: citizenFormRouteName,
        builder: (ctx, state) => const CitizenFormPage(),
      ),
    ],
  ),
);
