import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentasion/riverpod/app_config/app_initialize_notifier.dart';
import 'utils/utils.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initializeApplication = ref.watch(appInitialize);

    return initializeApplication.when(
      data: (_) {
        final route = ref.watch(goRouter);
        final theme = ThemeData();
        return MaterialApp.router(
          title: "Yuuran",
          color: primary,
          debugShowCheckedModeBanner: false,
          theme: theme.copyWith(
            textTheme: bFontTextTheme(context),
            scaffoldBackgroundColor: scaffoldColor,
            colorScheme: theme.colorScheme.copyWith(
              primary: primary,
              secondary: secondary,
            ),
          ),
          routeInformationParser: route.routeInformationParser,
          routerDelegate: route.routerDelegate,
        );
      },
      error: (error, trace) => ErrorMaterialApp(message: "$error"),
      loading: () => const LoadingMaterialApp(),
    );
  }
}

class LoadingMaterialApp extends StatelessWidget {
  const LoadingMaterialApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class ErrorMaterialApp extends StatelessWidget {
  const ErrorMaterialApp({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
