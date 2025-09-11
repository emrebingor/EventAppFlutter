import 'package:event_app/data/provider/tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final class BottomNavigationTabBarWidget extends StatelessWidget {
  const BottomNavigationTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home,
                index: 0,
              ),
              _NavItem(
                icon: Icons.calendar_month,
                index: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _NavItem extends StatelessWidget {
  final IconData icon;
  final int index;

  const _NavItem({
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
      ),
      onPressed: () {
        if(index == 0 || index == 1) {
          context.read<TabProvider>().setTab(index);
        }
      },
    );
  }
}