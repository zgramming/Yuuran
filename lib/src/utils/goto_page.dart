import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'go_router.dart';
import 'utils.dart';

/// Class ini digunakan untuk menempatkan semua navigasi yang mempunyai parameter
/// Karena akan sedikit menyusahkan jika aplikasi sudah besar, dan navigasi bertebaran dimana-mana
/// Kita hanya perlu mengedit Class ini untuk mengubah isi parameter atau lokasi tujuan navigasi yang dibutuhkan
/// 🥰🥰😘
class GoToPage {
  GoToPage._();
  static final instance = GoToPage._();

  void Function()? duesFormNew(BuildContext context) {
    context.pushNamed(duesFormRouteName, params: {"duesDetailID": "new"});
    return null;
  }

  void Function()? duesFormUpdate(BuildContext context, {required String duesDetailID}) {
    context.pushNamed(duesFormRouteName, params: {
      "duesDetailID": duesDetailID,
    });
    return null;
  }

  void Function()? citizenDues(BuildContext context, {required String username}) {
    final params = {"username": username};
    context.pushNamed(citizenDuesRouteName, params: params);

    return null;
  }

  void Function()? citizenFormNew(BuildContext context) {
    final params = {"id": "-1"};
    context.pushNamed(citizenFormRouteName, params: params);

    return null;
  }

  void Function()? citizenFormUpdate(
    BuildContext context, {
    required int id,
  }) {
    final params = {"id": "$id"};
    context.pushNamed(citizenFormRouteName, params: params);

    return null;
  }
}

final gotoPage = GoToPage.instance;
