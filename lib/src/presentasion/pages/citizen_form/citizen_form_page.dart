import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/user/user_model.dart';
import '../../../utils/utils.dart';

class CitizenFormPage extends ConsumerStatefulWidget {
  const CitizenFormPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  createState() => _CitizenFormPageState();
}

class _CitizenFormPageState extends ConsumerState<CitizenFormPage> {
  UserModel? _user;
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _getCitizenByID());
  }

  Future<void> _getCitizenByID() async {
    final user = (await ref.read(citizenNotifier.notifier).getByID(widget.id)).item;
    setState(() {
      _user = user;
      usernameController.text = _user?.username ?? "";
      nameController.text = _user?.name ?? "";
      emailController.text = _user?.email ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _user?.id == null ? "Tambah Warga" : "Update ${_user!.name}",
          style: hFontWhite.copyWith(
            // fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16.0),
                ...[
                  Text(
                    'Username',
                    style: hFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: usernameController,
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: sharedFunction.myInputDecoration.copyWith(hintText: "Username"),
                  ),
                ],
                const SizedBox(height: 16.0),
                ...[
                  Text(
                    'Nama',
                    style: hFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: nameController,
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: sharedFunction.myInputDecoration.copyWith(hintText: "Nama"),
                  ),
                ],
                const SizedBox(height: 16.0),
                ...[
                  Text(
                    'Email',
                    style: hFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: sharedFunction.myInputDecoration.copyWith(hintText: "Email"),
                  ),
                ],

                /// Section Password & Confirmation Password
                /// When mode update, we should hidden this input
                /// We let user to update their password individual
                if (_user?.id == null)
                  _PasswordSection(
                    passwordController: passwordController,
                    passwordConfirmationController: passwordConfirmationController,
                  ),

                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final result = await ref.read(citizenNotifier.notifier).saveCitizen(
                            id: _user?.id,
                            username: usernameController.text,
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            passwordConfirmation: passwordController.text,
                          );

                      if (result.isError) {
                        throw Exception(result.message!);
                      }

                      sharedFunction.showSnackbar(
                        context,
                        color: Colors.green,
                        title: result.message!,
                      );
                    } catch (e) {
                      sharedFunction.showSnackbar(
                        context,
                        color: Colors.red,
                        title: "$e",
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: primary,
                  ),
                  child: Text(
                    "Submit",
                    style: bFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordSection extends StatelessWidget {
  const _PasswordSection({
    Key? key,
    required this.passwordController,
    required this.passwordConfirmationController,
  }) : super(key: key);

  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...[
          const SizedBox(height: 16.0),
          ...[
            Text(
              'Password',
              style: hFont.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              style: bFont.copyWith(fontWeight: FontWeight.bold),
              decoration: sharedFunction.myInputDecoration.copyWith(
                hintText: "Password",
              ),
            ),
          ],
          const SizedBox(height: 16.0),
          ...[
            Text(
              'Konfirmasi Password',
              style: hFont.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: passwordConfirmationController,
              obscureText: true,
              style: bFont.copyWith(fontWeight: FontWeight.bold),
              decoration: sharedFunction.myInputDecoration.copyWith(
                hintText: "Konfirmasi Password",
              ),
            ),
          ],
        ],
      ],
    );
  }
}
