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
      data: (data) => const MyMaterialAppRouter(),
      error: (error, trace) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text("Error $error"),
          ),
        ),
      ),
      loading: () => const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class MyMaterialAppRouter extends ConsumerWidget {
  const MyMaterialAppRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  }
}
