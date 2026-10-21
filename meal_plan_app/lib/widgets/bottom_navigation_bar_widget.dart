
import 'package:flutter/material.dart';
import '../theme.dart';
import '../screens/home_screen.dart';
import '../screens/planner_screen.dart';
import '../data/planner_data.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    final selectedIndex = currentRoute == '/planner' ? 1 : 0;

    void onItemTapped(int index) {
      if (index == selectedIndex) return;

      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            settings: const RouteSettings(name: '/recipes'),
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            settings: const RouteSettings(name: '/planner'),
            builder: (context) => PlannerScreen(
              plannedRecipes: plannedRecipes,
            ),
          ),
        );
      }
    }

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      backgroundColor: const Color(0xFFF5F5F5),
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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined, size: 27),
          activeIcon: Icon(Icons.menu_book_rounded, size: 29),
          label: 'Recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined, size: 27),
          activeIcon: Icon(Icons.calendar_month_rounded, size: 29),
          label: 'Planner',
        ),
      ],
    );
  }
}
