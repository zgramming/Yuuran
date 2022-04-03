import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const _splashRouteName = "splash";
const _onboardingRouteName = "onboarding";
const _loginRouteName = "login";
const _welcomeRouteName = "welcome";

final goRouter = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/",
    redirect: (state) {
      return null;
    },
    routes: [
      GoRoute(
        path: "/",
        name: _splashRouteName,
        builder: (ctx, state) => Scaffold(appBar: AppBar(title: Text("Splash"))),
      ),
      GoRoute(
        path: "/onboarding",
        name: _onboardingRouteName,
        builder: (ctx, state) => Scaffold(appBar: AppBar(title: Text("Onboarding"))),
      ),
      GoRoute(
        path: "/login",
        name: _loginRouteName,
        builder: (ctx, state) => Scaffold(appBar: AppBar(title: Text("Login"))),
      ),
      GoRoute(
        path: "/welcome",
        name: _welcomeRouteName,
        builder: (ctx, state) => Scaffold(appBar: AppBar(title: Text("Welcome"))),
      ),
    ],
  );
});
