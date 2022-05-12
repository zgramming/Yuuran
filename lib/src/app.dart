import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentasion/riverpod/app_config/app_config_notifier.dart';
import 'utils/utils.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _initializeApplication = ref.watch(appConfigInitialize);

    return _initializeApplication.when(
      data: (_) {
        final _goRouter = ref.watch(goRouter);
        final _theme = ThemeData();
        return MaterialApp.router(
          title: "Yuuran",
          color: primary,
          debugShowCheckedModeBanner: false,
          theme: _theme.copyWith(
            textTheme: bFontTextTheme(context),
            scaffoldBackgroundColor: scaffoldColor,
            colorScheme: _theme.colorScheme.copyWith(
              primary: primary,
              secondary: secondary,
            ),
          ),
          routeInformationParser: _goRouter.routeInformationParser,
          routerDelegate: _goRouter.routerDelegate,
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
