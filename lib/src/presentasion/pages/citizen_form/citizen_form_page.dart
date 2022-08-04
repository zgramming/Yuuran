
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/user/user_model.dart';
import '../../../utils/utils.dart';
import '../../riverpod/citizen/citizen_action_notifier.dart';
import '../../riverpod/citizen/citizen_notifier.dart';
import '../widgets/modal_loading.dart';

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
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    /// Listen [citizenById]
    ref.listen<AsyncValue<UserModel?>>(getCitizenById(widget.id ), (_, state) {
      state.whenData((value) {
        setState(() {
          usernameController.text = value?.username ?? '';
          nameController.text = value?.name ?? '';
          emailController.text = value?.email ?? '';
        });
      });
    });

    /// Listen [save] citizen notifier
    ref.listen<AsyncValue<String>>(
      citizenActionNotifier.select((value) => value.saveAsync),
      (_, state) {
        if (state is AsyncLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const ModalLoadingWidget(),
          );
        } else {
          /// Close modal loading
          Navigator.pop(context);

          state.whenOrNull(
            data: (message) => sharedFunction.showSnackbar(
              context,
              color: Colors.green,
              title: message,
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

    final future = ref.watch(getCitizenById(widget.id ));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          future.value?.id == null ? "Tambah Warga" : "Update ${future.value?.name ?? ""}",
          style: hFontWhite.copyWith(
            // fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (future is AsyncLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (future is AsyncError) {
            return Center(child: Text("${future.error}"));
          }

          return SingleChildScrollView(
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
                    if (widget.id <= 0)
                      _PasswordSection(
                        passwordController: passwordController,
                        passwordConfirmationController: passwordConfirmationController,
                      ),

                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        await ref.read(citizenActionNotifier.notifier).save(
                              id: widget.id,
                              username: usernameController.text,
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              passwordConfirmation: passwordController.text,
                            );
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
          );
        },
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
