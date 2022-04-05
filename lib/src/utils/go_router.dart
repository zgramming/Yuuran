import 'dart:collection';
import 'dart:developer';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:yuuran/main.dart';

import 'utils.dart';

const splashRouteName = "splash";
const onboardingRouteName = "onboarding";
const loginRouteName = "login";
const welcomeRouteName = "welcome";

const duesRouteName = "dues";
const duesCategoryRouteName = "duesCategory";
const duesCategoryFormRouteName = "duesCategoryForm";

const citizenDuesRouteName = "citizenDues";
const citizenFormRouteName = "citizenForm";
const citizenProfileRouteName = "citizenProfile";

const myProfileRouteName = "myProfile";

final goRouter = Provider<GoRouter>(
  (ref) => GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/welcome",
    redirect: (state) {
      return null;
    },
    routes: [
      GoRoute(
        path: "/",
        name: splashRouteName,
        builder: (ctx, state) => const SplashPage(),
      ),
      GoRoute(
        path: "/onboarding",
        name: onboardingRouteName,
        builder: (ctx, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: "/login",
        name: loginRouteName,
        builder: (ctx, state) => const LoginPage(),
      ),
      GoRoute(
        path: "/welcome",
        name: welcomeRouteName,
        builder: (ctx, state) => const WelcomePage(),
      ),
      GoRoute(
        path: "/dues",
        name: duesRouteName,
        builder: (ctx, state) => const DuesFormPage(),
        routes: [
          /// [/dues/category]
          GoRoute(
            path: "category",
            name: duesCategoryRouteName,
            builder: (ctx, state) => const DuesCategoryPage(),
            routes: [
              /// [/dues/category/form/code-category]
              GoRoute(
                path: "form/:codeCategory",
                name: duesCategoryFormRouteName,
                builder: (ctx, state) => const DuesCategoryFormPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: "/citizen/dues/:username",
        name: citizenDuesRouteName,
        builder: (ctx, state) => const CitizenDuesPage(),
      ),
      GoRoute(
        path: "/citizen/form/:username",
        name: citizenFormRouteName,
        builder: (ctx, state) => const CitizenFormPage(),
      ),
    ],
  ),
);

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

class DuesCategoryFormPage extends StatelessWidget {
  const DuesCategoryFormPage({
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
          "Iuran Kebersihan",
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
                    'Kode',
                    style: hFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: _inputDecoration.copyWith(hintText: "Kode"),
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
                    'Deskripsi',
                    style: hFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    minLines: 3,
                    maxLines: 3,
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: _inputDecoration.copyWith(hintText: "Nama"),
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

class DuesCategoryPage extends StatelessWidget {
  const DuesCategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Kategori Iuran",
          style: hFontWhite.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (ctx, state) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: primaryShade,
                child: FittedBox(
                  child: Text(
                    "IKB",
                    style: bFontWhite.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text(
                "Iuran Kebersihan",
                style: hFont.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Disini deskripsi iuran kebersihan loh",
                style: bFont.copyWith(
                  color: grey,
                  fontSize: 10.0,
                ),
              ),
              trailing: IconButton(
                onPressed: () => context.pushNamed(
                  duesCategoryFormRouteName,
                  params: {
                    "codeCategory": "test",
                  },
                ),
                icon: const Icon(Icons.edit, color: info),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CitizenDuesPage extends StatelessWidget {
  const CitizenDuesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Iuran XXX"),
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (ctx) => const CitizenDuesFilter(),
              );
            },
            icon: const Icon(Icons.filter_alt),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: secondary,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2.0,
                  color: black.withOpacity(.25),
                ),
              ],
            ),
            child: Text(
              "Iuran Kebersihan April 2022",
              style: hFontWhite.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                letterSpacing: 1.1,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () => context.pushNamed(duesRouteName),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: index.isEven ? warning : secondary,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                          ),
                          child: Text(
                            index.isOdd ? "IURAN KEAMANAN (IRKM)" : "IURAN KEBERSIHAN (IRKB)",
                            style: hFontWhite,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Zeffry Reynando",
                            style: hFont.copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Update terakhir ${GlobalFunction.formatYMDHM(DateTime.now())}",
                              style: bFont.copyWith(
                                color: grey,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          trailing: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                GlobalFunction.formatNumber(index.isOdd ? 25000 : 10000),
                                style: bFont.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CitizenDuesFilter extends StatefulWidget {
  const CitizenDuesFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<CitizenDuesFilter> createState() => _CitizenDuesFilterState();
}

class _CitizenDuesFilterState extends State<CitizenDuesFilter> {
  final years = <int>[
    for (final year in GlobalFunction.range(min: 2010, max: DateTime.now().year)) year
  ];

  final months = <int>[for (final month in GlobalFunction.range(min: 1, max: 12)) month];

  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;
  String? _selectedDuesCategory;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text(
        "Filter berdasarkan :",
        style: hFont.copyWith(fontWeight: FontWeight.bold),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16.0),
          DropdownButton<String>(
            value: _selectedDuesCategory,
            isExpanded: true,
            hint: Text(
              "Pilih Kategori",
              style: bFont.copyWith(
                color: grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            onChanged: (value) => setState(() => _selectedDuesCategory = value),
            items: ["Iuran Keamanan", "Iuran Kesehatan", "Iuran Kebersihan"]
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: bFont.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16.0),
          DropdownButton<int>(
            isExpanded: true,
            items: years
                .map<DropdownMenuItem<int>>(
                  (year) => DropdownMenuItem<int>(
                    child: Text(
                      '$year',
                      style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    value: year,
                  ),
                )
                .toList(),
            value: _selectedYear,
            onChanged: (value) => setState(() => _selectedYear = value ?? DateTime.now().year),
          ),
          const SizedBox(height: 16.0),
          DropdownButton<int>(
            isExpanded: true,
            items: months
                .map<DropdownMenuItem<int>>(
                  (month) => DropdownMenuItem<int>(
                    child: Text(
                      sharedFunction.monthString(month),
                      style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    value: month,
                  ),
                )
                .toList(),
            value: _selectedMonth,
            onChanged: (value) => setState(() => _selectedMonth = value ?? DateTime.now().month),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
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
    );
  }
}

class DuesFormPage extends StatefulWidget {
  const DuesFormPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DuesFormPage> createState() => _DuesFormPageState();
}

class _DuesFormPageState extends State<DuesFormPage> {
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  String? _selectedCitizen;
  String? _selectedDuesCategory;
  bool _selectedPaidBySomeoneElse = false;

  static const _locale = 'id';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: grey),
    );
    final _inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: "0",
      hintStyle: bFont.copyWith(fontSize: 12.0, color: grey),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder.copyWith(borderSide: const BorderSide(color: primary)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Iuran",
          style: hFontWhite.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...[
                        Text(
                          'Pilih Warga',
                          style: hFont.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: Text(
                            "Pilih warga yang ingin dibuatkan iuran",
                            style: bFont.copyWith(fontSize: 12.0, color: grey),
                          ),
                          value: _selectedCitizen,
                          items: ["Zeffry Reynando", "Syarif", "Helmi", "Engkoh"]
                              .map((e) => DropdownMenuItem(child: Text(e), value: e))
                              .toList(),
                          onChanged: (value) => setState(() => _selectedCitizen = value),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                      const SizedBox(height: 16.0),
                      ...[
                        Text(
                          'Pilih Kategori Iuran',
                          style: hFont.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: Text(
                            "Pilih kategori iuran",
                            style: bFont.copyWith(fontSize: 12.0, color: grey),
                          ),
                          value: _selectedDuesCategory,
                          items: ["Iuran Kebersihan", "Iuran Kemanan", "Iuran Kesehatan"]
                              .map((e) => DropdownMenuItem(child: Text(e), value: e))
                              .toList(),
                          onChanged: (value) => setState(() => _selectedDuesCategory = value),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                      const SizedBox(height: 16.0),
                      ...[
                        Text(
                          'Jumlah Iuran',
                          style: hFont.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: amountController,
                          style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 12.0),
                          keyboardType: TextInputType.number,
                          decoration: _inputDecoration.copyWith(prefixText: _currency),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            log("before value $value");
                            if (value.isNotEmpty) value = _formatNumber(value.replaceAll(",", ""));

                            log("after value value $value");
                            amountController.value = TextEditingValue(
                              text: value,
                              selection: TextSelection.collapsed(offset: value.length),
                            );
                          },
                        ),
                        const SizedBox(height: 8.0),
                      ],
                      const SizedBox(height: 16.0),
                      ...[
                        CheckboxListTile(
                          value: _selectedPaidBySomeoneElse,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: const EdgeInsets.only(),
                          activeColor: primary,
                          title: Text(
                            "Dibayarkan orang lain ?",
                            style: hFont.copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Memberitahukan bahwa iuran ini dibayarkan oleh orang lain, bukan dengan warga yang bersangkutan.",
                            style: bFont.copyWith(
                              fontSize: 10.0,
                              color: grey,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() => _selectedPaidBySomeoneElse = value ?? false);
                          },
                        ),
                      ],
                      const SizedBox(height: 16.0),
                      ...[
                        Text(
                          'Keterangan',
                          style: hFont.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: descriptionController,
                          style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 12.0),
                          minLines: 3,
                          maxLines: 3,
                          decoration: _inputDecoration.copyWith(hintText: "Keterangan"),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          "Kamu bisa menggunakan field ini untuk memberikan keterangan pada iuran ini, bisa berupa alasan pembayaran iuran tidak full, alasan kenapa iuran dibayar oleh pihak lain, dan sebagainya.",
                          style: bFont.copyWith(
                            fontSize: 10.0,
                            color: grey,
                          ),
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
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentIndex = 0;

  _setIndex(int index) {
    setState(() => _currentIndex = index);
  }

  final _items = const <TabItem>[
    TabItem(
      icon: Icon(Icons.home, color: primaryShade2),
      activeIcon: Icon(Icons.home, color: Colors.white),
    ),
    TabItem(
      icon: Icon(Icons.search, color: primaryShade2),
      activeIcon: Icon(Icons.search, color: Colors.white),
    ),
    TabItem(
      icon: Icon(Icons.add, color: primary),
      activeIcon: Icon(Icons.add, color: Colors.white),
    ),
    TabItem(
      icon: Icon(Icons.calendar_month, color: primaryShade2),
      activeIcon: Icon(Icons.calendar_month, color: Colors.white),
    ),
    TabItem(
      icon: Icon(Icons.person, color: primaryShade2),
      activeIcon: Icon(Icons.person, color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: const [
            HomePage(),
            SearchPage(),
            ChooseActionPage(),
            CalendarPage(),
            AccountPage(),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        elevation: 0,
        style: TabStyle.fixedCircle,
        items: _items,
        activeColor: secondary,
        backgroundColor: primary,
        color: primaryShade2,
        onTap: _setIndex,
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: secondary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Hello ",
                        children: [
                          TextSpan(
                            text: "Zeffry Reynando",
                            style: hFontWhite.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          )
                        ],
                      ),
                      style: hFontWhite.copyWith(fontSize: 14.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "Halaman Account ini untuk mengatur tentang profile kamu",
                      style: bFontWhite.copyWith(fontWeight: FontWeight.w300, fontSize: 12.0),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              children: [
                AccountMenu(
                  onTap: () {},
                  icon: Icons.edit,
                  circleBackgroundColor: info,
                  circleForegroundColor: Colors.white,
                  title: "Profile",
                  subtitle: "Mengatur profile kamu",
                ),
                AccountMenu(
                  onTap: () {},
                  icon: Icons.settings_applications_outlined,
                  circleBackgroundColor: Colors.lightBlue,
                  circleForegroundColor: Colors.white,
                  title: "Tentang Aplikasi",
                  subtitle: "Informasi lengkap tentang aplikasi Yuuran",
                ),
                AccountMenu(
                  onTap: () {},
                  icon: Icons.logout,
                  circleBackgroundColor: danger,
                  circleForegroundColor: Colors.white,
                  title: "LOGOUT",
                  subtitle: "Keluar aplikasi",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AccountMenu extends StatelessWidget {
  const AccountMenu({
    Key? key,
    this.onTap,
    this.circleBackgroundColor,
    this.circleForegroundColor,
    required this.icon,
    this.title = '',
    this.subtitle = '',
  }) : super(key: key);

  final void Function()? onTap;
  final Color? circleBackgroundColor;
  final Color? circleForegroundColor;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              color: black.withOpacity(.25),
            ),
          ],
        ),
        // margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: CircleAvatar(
                  backgroundColor: circleBackgroundColor,
                  foregroundColor: circleForegroundColor,
                  child: Icon(icon),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                title,
                style:
                    bFont.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.1, fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                subtitle,
                style: bFont.copyWith(
                  letterSpacing: 1.1,
                  color: grey,
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  final kEvents = LinkedHashMap<DateTime, List<MyEvent>>(
    equals: isSameDay,
    hashCode: (date) => date.day * 1000000 + date.month * 10000 + date.year,
  );

  final _myEvents = LinkedHashMap<DateTime, List<MyEvent>>(
    equals: isSameDay,
    hashCode: (date) => date.day * 1000000 + date.month * 10000 + date.year,
  );

  @override
  void initState() {
    super.initState();
    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final _eventSource = {
      for (var item in List.generate(10, (index) => index))
        DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5):
            List.generate(item % 4 + 1, (index) => MyEvent(title: 'Event $item | ${index + 1}'))
    }..addAll({
        kToday: const [
          MyEvent(title: "Event 1"),
          MyEvent(title: "Event 2"),
        ]
      });

    _myEvents.addAll(_eventSource);
  }

  final calendarHeaderStyle = HeaderStyle(
    decoration: const BoxDecoration(
      color: primary,
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
    ),
    headerMargin: const EdgeInsets.only(bottom: 24.0),
    titleCentered: true,
    titleTextStyle: hFontWhite.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
    leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
    rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
  );

  final daysOfWeekStyle = DaysOfWeekStyle(
    weekendStyle: hFont.copyWith(color: primary, fontWeight: FontWeight.bold),
    weekdayStyle: hFont.copyWith(),
  );

  final availableCalendarFormats = const {CalendarFormat.month: 'month'};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 32.0,
        ),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: TableCalendar(
                headerStyle: calendarHeaderStyle,
                focusedDay: _focusedDay,
                daysOfWeekStyle: daysOfWeekStyle,
                locale: 'id_ID',
                firstDay: DateTime.utc(DateTime.now().year - 10),
                lastDay: DateTime.utc(DateTime.now().year + 10),
                availableGestures: AvailableGestures.horizontalSwipe,
                eventLoader: (date) => _myEvents[date] ?? [],
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: primaryShade4,
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if (events.isEmpty) return null;
                    return Card(
                      color: secondary,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "${events.length} Iuran",
                          style: bFontWhite.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                availableCalendarFormats: availableCalendarFormats,
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
            const SizedBox(height: 32.0),
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: index.isEven ? warning : secondary,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                        ),
                        child: Text(
                          index.isOdd ? "IURAN KEAMANAN (IRKM)" : "IURAN KEBERSIHAN (IRKB)",
                          style: hFontWhite,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Zeffry Reynando",
                          style: hFont.copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Update terakhir ${GlobalFunction.formatYMDHM(DateTime.now())}",
                            style: bFont.copyWith(
                              color: grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        trailing: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              GlobalFunction.formatNumber(index.isOdd ? 25000 : 10000),
                              style: bFont.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}

class ChooseActionPage extends StatelessWidget {
  const ChooseActionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          ChooseActionMenu(
            onTap: () => context.pushNamed(duesRouteName),
            circleBackgroudColor: secondary,
            iconData: Icons.attach_money_rounded,
            title: "Tambah Iuran",
            subtitle: "Membuat dan menyimpan iuran warga",
          ),
          const SizedBox(height: 16.0),
          ChooseActionMenu(
            onTap: () => context.pushNamed(duesCategoryRouteName),
            circleBackgroudColor: warning,
            iconData: Icons.category_rounded,
            title: "Kategori Iuran",
            subtitle: "Memanage Kategori Iuran ",
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class ChooseActionMenu extends StatelessWidget {
  const ChooseActionMenu({
    Key? key,
    this.title = '',
    this.subtitle = '',
    this.circleBackgroudColor,
    this.circleForegroundColor,
    required this.iconData,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Color? circleBackgroudColor;
  final Color? circleForegroundColor;
  final IconData iconData;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: CircleAvatar(
          backgroundColor: circleBackgroudColor ?? primary,
          foregroundColor: circleForegroundColor ?? Colors.white,
          child: Icon(iconData),
        ),
        title: Text(
          title,
          style: hFont.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: bFont.copyWith(fontSize: 10.0, color: grey),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(color: grey),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16.0),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 12.0),
              decoration: InputDecoration(
                hintText: "Cari warga berdasarkan namanya",
                hintStyle: bFont.copyWith(fontSize: 10.0, color: grey),
                prefixIcon: const Icon(Icons.search),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder.copyWith(
                  borderSide: const BorderSide(color: primary),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                    onPressed: () => context.pushNamed(
                      citizenFormRouteName,
                      params: {
                        "username": "zeffry",
                      },
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: secondary,
                      side: const BorderSide(color: secondary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: Text(
                      "Tambah Warga",
                      style: bFont.copyWith(
                        color: secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  for (final entry in sharedFunction
                      .groupByFirstCharacter(Person.persons.map((e) => e.name).toList())
                      .entries) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Card(
                        color: primary,
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            entry.key,
                            style: hFontWhite.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ListView.separated(
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemCount: entry.value.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        final name = entry.value[index];
                        return ListTile(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text(
                                  "Pilih aksi",
                                  style: hFont.copyWith(fontWeight: FontWeight.bold),
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        context.pushNamed(
                                          citizenDuesRouteName,
                                          params: {
                                            "username": name,
                                          },
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(16.0),
                                      ),
                                      child: Text(
                                        "Lihat Iuran",
                                        style: bFont.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(16.0),
                                      ),
                                      child: Text(
                                        "Update Profile",
                                        style: bFont.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(16.0),
                                    ),
                                    child: Text("Batal", style: bFont.copyWith(color: grey)),
                                  ),
                                ],
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundColor: primaryShade2,
                            child: FittedBox(
                              child: Text(
                                name[0],
                                style: hFontWhite.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          title: Text(
                            '$name',
                            style: hFont.copyWith(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Hello ",
                          children: [
                            TextSpan(
                              text: "Zeffry Reynando",
                              style: hFont.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        style: hFont.copyWith(
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: OutlinedButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (ctx) => const MonthYearPicker(),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: secondaryDark)),
                          child: Text(
                            "Ubah Bulan & Tahun",
                            style: bFont.copyWith(color: secondaryDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2.0,
                        color: black.withOpacity(.25),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      pathLogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            Text(
              "Statistik Iuran April 2022",
              style: hFont.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 20.0,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: sharedFunction.vh(context) / 4,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 3,
                itemExtent: sharedFunction.vw(context) / 1.25,
                itemBuilder: (ctx, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                    margin: const EdgeInsets.only(right: 16.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [secondary, secondaryShade],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2.0,
                          color: black.withOpacity(.25),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Iuran Kebersihan (IRK)'.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: hFontWhite.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "4/10 ",
                                      children: [
                                        TextSpan(
                                          text: "Orang",
                                          style: bFontWhite.copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    style: bFontWhite.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Dana terkumpul",
                                          style: bFontWhite.copyWith(fontSize: 10.0)),
                                      Text(
                                        GlobalFunction.formatNumber(250000),
                                        style: hFontWhite.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Container(
                                height: 10.0,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: (4 / 10),
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: secondaryDark,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Aktifitas Terbaru April 2022",
                  style: bFont.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Lihat Semua',
                    style: bFont.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 10.0, color: secondaryDark),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: index.isEven ? warning : secondary,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                        ),
                        child: Text(
                          index.isOdd ? "IURAN KEAMANAN (IRKM)" : "IURAN KEBERSIHAN (IRKB)",
                          style: hFontWhite,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Zeffry Reynando",
                          style: hFont.copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Update terakhir ${GlobalFunction.formatYMDHM(DateTime.now())}",
                            style: bFont.copyWith(
                              color: grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        trailing: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              GlobalFunction.formatNumber(index.isOdd ? 25000 : 10000),
                              style: bFont.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

class MonthYearPicker extends StatefulWidget {
  const MonthYearPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<MonthYearPicker> createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  final years = <int>[
    for (final year in GlobalFunction.range(min: 2010, max: DateTime.now().year)) year
  ];

  final months = <int>[for (final month in GlobalFunction.range(min: 1, max: 12)) month];

  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text(
        "Pilih Bulan dan Tahun",
        style: hFont.copyWith(fontWeight: FontWeight.bold),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16.0),
          DropdownButton<int>(
            isExpanded: true,
            items: years
                .map<DropdownMenuItem<int>>(
                  (year) => DropdownMenuItem<int>(
                    child: Text(
                      '$year',
                      style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    value: year,
                  ),
                )
                .toList(),
            value: _selectedYear,
            onChanged: (value) {
              setState(() => _selectedYear = value ?? DateTime.now().year);
            },
          ),
          const SizedBox(height: 16.0),
          DropdownButton<int>(
            isExpanded: true,
            items: months
                .map<DropdownMenuItem<int>>(
                  (month) => DropdownMenuItem<int>(
                    child: Text(
                      sharedFunction.monthString(month),
                      style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    value: month,
                  ),
                )
                .toList(),
            value: _selectedMonth,
            onChanged: (value) {
              setState(() => _selectedMonth = value ?? DateTime.now().month);
            },
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
              primary: primary,
            ),
            child: Text(
              "Update",
              style: bFont.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

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

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _decoration = PageDecoration(
    titleTextStyle: hFontWhite.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 28.0,
    ),
    bodyTextStyle: bFontWhite.copyWith(
      fontSize: 12.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: primary,
      pages: [
        PageViewModel(
          image: Center(
            child: Image.asset(
              pathOnboarding1,
              fit: BoxFit.cover,
              width: sharedFunction.vw(context) / 2,
            ),
          ),
          title: "Permudah Pencatatan",
          body: "Tidak perlu membawa buku kemana-mana lagi untuk pencatatan iuran",
          decoration: _decoration,
        ),
        PageViewModel(
          image: Center(
            child: Image.asset(
              pathOnboarding2,
              fit: BoxFit.cover,
              width: sharedFunction.vw(context) / 2,
            ),
          ),
          title: "Permudah Pemantauan",
          body: "Lebih mudah untuk memantau warga yang sudah bayar iuran atau belum",
          decoration: _decoration,
        ),
        PageViewModel(
          image: Center(
            child: Image.asset(
              pathOnboarding3,
              fit: BoxFit.cover,
              width: sharedFunction.vw(context) / 2,
            ),
          ),
          title: "Permudah Laporan",
          body: "Keluar masuk iuran pun lebih transparan dan mudah untuk dibuatkan laporannya",
          decoration: _decoration,
        ),
        PageViewModel(
          image: Center(
            child: Image.asset(
              pathOnboarding4,
              fit: BoxFit.cover,
              width: sharedFunction.vw(context) / 2,
            ),
          ),
          title: "Warga Senang Kamu Senang",
          body: '',
          decoration: _decoration,
        ),
      ],
      done: Text("Selesai", style: bFontWhite.copyWith(fontWeight: FontWeight.bold)),
      next: Text("Lanjut", style: bFontWhite),
      onDone: () => context.goNamed(loginRouteName),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initialize().then((_) {
      context.goNamed(onboardingRouteName);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 10),
            Text("Tunggu sebentar ya...", style: bFont.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
