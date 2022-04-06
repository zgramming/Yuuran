import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  static final _inputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: "Username",
    hintStyle: bFont.copyWith(fontSize: 12.0),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: secondary, width: 1),
    ),
  );

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
                      style: bFont.copyWith(color: black, fontSize: 16.0),
                      decoration: _inputDecoration,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: bFont.copyWith(color: black, fontSize: 16.0),
                      obscureText: true,
                      obscuringCharacter: "⁂",
                      decoration: _inputDecoration.copyWith(hintText: "Password"),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.goNamed(welcomeRouteName),
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
