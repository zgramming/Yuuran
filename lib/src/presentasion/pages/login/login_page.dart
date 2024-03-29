import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/authentication/authentication_response.dart';
import '../../../utils/utils.dart';
import '../../riverpod/user/authentication_notifier.dart';
import '../widgets/modal_loading.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AuthenticationResponse?>>(
      authenticationNotifier.select((value) => value.authenticationAsync),
      (_, state) async {
        if (state is AsyncLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const ModalLoadingWidget(),
          );
        } else {
          /// Close modal dialog
          Navigator.pop(context);

          state.whenOrNull(
            data: (response) => sharedFunction.showSnackbar(
              context,
              color: Colors.green,
              title: response?.message ?? '',
            ),
            error: (error, trace) => sharedFunction.showSnackbar(
              context,
              color: Colors.red,
              title: "$error",
            ),
          );
        }
      },
    );
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
                        await ref.read(authenticationNotifier.notifier).login(
                              username: usernameController.text,
                              password: passwordController.text,
                            );
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
