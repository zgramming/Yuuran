import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/utils.dart';
import '../account/account_page.dart';
import '../calendar/calendar_page.dart';
import '../choose_action/choose_action_page.dart';
import '../home/home_page.dart';
import '../search/search_page.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  int _currentIndex = 0;

  _setIndex(int index) => setState(() => _currentIndex = index);

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
