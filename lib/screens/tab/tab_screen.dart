import 'package:event_app/components/tab_bar/bottom_navigation_tab_bar_widget.dart';
import 'package:event_app/data/provider/tab_provider.dart';
import 'package:event_app/screens/event/event_list_screen.dart';
import 'package:event_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

final class _TabScreenState extends State<TabScreen> {

  final List<Widget> pages = const [
    HomeScreen(),
    EventListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final tabProvider = context.watch<TabProvider>();

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: pages[tabProvider.selectedIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const BottomNavigationTabBarWidget(),
      ),
    );
  }
}