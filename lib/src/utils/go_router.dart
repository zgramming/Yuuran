import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'utils.dart';

const splashRouteName = "splash";
const onboardingRouteName = "onboarding";
const loginRouteName = "login";
const welcomeRouteName = "welcome";

final goRouter = Provider<GoRouter>((ref) {
  return GoRouter(
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
    ],
  );
});

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
            AddPage(),
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [BoxShadow(blurRadius: 2.0, color: black.withOpacity(.25))],
                    ),
                    // margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: CircleAvatar(
                              backgroundColor: danger,
                              foregroundColor: Colors.white,
                              child: Icon(Icons.logout),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            "LOGOUT",
                            style: bFont.copyWith(
                                fontWeight: FontWeight.bold, letterSpacing: 1.1, fontSize: 16.0),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            "Keluar aplikasi",
                            style: bFont.copyWith(
                              letterSpacing: 1.1,
                              color: grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Calendar", style: bFont);
  }
}

class AddPage extends StatelessWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Add", style: bFont);
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Search", style: bFont);
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
                            style: bFont.copyWith(color: grey),
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
