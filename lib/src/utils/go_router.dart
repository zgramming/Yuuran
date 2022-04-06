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

const duesRouteName = "dues";
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
        path: "/dues",
        name: duesRouteName,
        builder: (ctx, state) => const DuesFormPage(),
        routes: [
          /// [/dues/category]
          GoRoute(
            path: "category",
            name: duesCategoryRouteName,
            builder: (ctx, state) => const DuesCategoryPage(),
            routes: [
              /// [/dues/category/form/code-category]
              GoRoute(
                path: "form/:codeCategory",
                name: duesCategoryFormRouteName,
                builder: (ctx, state) => const DuesCategoryFormPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: "/citizen/dues/:username",
        name: citizenDuesRouteName,
        builder: (ctx, state) => const CitizenDuesPage(),
      ),
      GoRoute(
        path: "/citizen/form/:username",
        name: citizenFormRouteName,
        builder: (ctx, state) => const CitizenFormPage(),
      ),
    ],
  ),
);
