import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class CitizenFormPage extends StatelessWidget {
  const CitizenFormPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: grey),
    );
    final _inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: "",
      hintStyle: bFont.copyWith(fontSize: 12.0, color: grey),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder.copyWith(borderSide: const BorderSide(color: primary)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tambah Warga",
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
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: _inputDecoration.copyWith(hintText: "Username"),
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
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: _inputDecoration.copyWith(hintText: "Nama"),
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
                    keyboardType: TextInputType.emailAddress,
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: _inputDecoration.copyWith(hintText: "Email"),
                  ),
                ],
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
                    obscureText: true,
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: _inputDecoration.copyWith(hintText: "Password"),
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
                    obscureText: true,
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: _inputDecoration.copyWith(hintText: "Konfirmasi Password"),
                  ),
                ],
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {},
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
