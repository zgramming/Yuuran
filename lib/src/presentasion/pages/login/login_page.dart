import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...[
                  Center(
                    child: Image.asset(
                      pathLogo,
                      fit: BoxFit.cover,
                      width: sharedFunction.vw(context) / 2.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Hallooo",
                    style: hFontWhite.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: "Silahkan login terlebih dahulu sebelum menggunakan aplikasi "),
                        TextSpan(
                          text: "Yuuran".toUpperCase(),
                          style: bFontWhite.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    style: bFontWhite.copyWith(
                      fontSize: 14.0,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: usernameController,
                      style: bFont.copyWith(color: black, fontSize: 16.0),
                      decoration: sharedFunction.myInputDecoration.copyWith(hintText: "Username"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      style: bFont.copyWith(color: black, fontSize: 16.0),
                      obscureText: isShowPassword ? false : true,
                      obscuringCharacter: "⁂",
                      decoration: sharedFunction.myInputDecoration.copyWith(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() => isShowPassword = !isShowPassword);
                          },
                          icon: Icon(isShowPassword ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await ref.read(userNotifier.notifier).login(
                              username: usernameController.text,
                              password: passwordController.text,
                            );

                        final notifier = ref.read(userNotifier);

                        if (notifier.isError) {
                          GlobalFunction.showSnackBar(
                            context,
                            snackBarType: SnackBarType.error,
                            content: Text(
                              notifier.message,
                              style: hFontWhite.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else {
                          /// Save Session User When success login
                          await ref.read(appConfigNotifer.notifier).setSessionUser(notifier.item);

                          GlobalFunction.showSnackBar(
                            context,
                            snackBarType: SnackBarType.success,
                            content: Text(
                              "Success Login",
                              style: hFontWhite.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                          context.goNamed(welcomeRouteName);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(24.0),
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        "Login".toUpperCase(),
                        style: bFontWhite.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
