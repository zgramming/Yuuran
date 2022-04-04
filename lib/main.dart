import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'src/utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  // turn off the # in the URLs on the web
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _goRouter = ref.watch(goRouter);
    final _theme = ThemeData();

    return MaterialApp.router(
      title: "Yuuran",
      debugShowCheckedModeBanner: false,
      theme: _theme.copyWith(
        textTheme: bFontTextTheme(context).copyWith(),
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
