
import 'package:flutter/material.dart';
import '../theme.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState
    extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,

      backgroundColor: Color(0xFFF5F5F5),
      selectedItemColor: AppColors.textPrimary,
      unselectedItemColor: AppColors.textSecondary,

      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,

      selectedLabelStyle: AppTextStyles.button.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w800,
      ),
      unselectedLabelStyle: AppTextStyles.subtitle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),

      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.menu_book_outlined,
            size: 27,
            weight: 600,
          ),
          activeIcon: Icon(
            Icons.menu_book_rounded,
            size: 29,
            weight: 700,
          ),
          label: 'Recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_month_outlined,
            size: 27,
            weight: 600,
          ),
          activeIcon: Icon(
            Icons.calendar_month_rounded,
            size: 29,
            weight: 700,
          ),
          label: 'Planner',
        ),
      ],
    );
  }
}
