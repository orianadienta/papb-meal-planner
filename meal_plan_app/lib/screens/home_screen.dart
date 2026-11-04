import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/recipe_controller.dart';
import '../models/recipe_model.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import 'detail_screen.dart';
import '../theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(mealListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Meal Planner',
          style: AppTextStyles.heading.copyWith(
            letterSpacing: 2,
            color: AppColors.background,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(15, 4, 15, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find Your Next Favorite Meal',
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                _searchField(ref),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Text(
                            'Explore',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                      Expanded(
                        child: _recipeSection(context, meals),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }

  Widget _searchField(WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          if (value.trim().isEmpty) {
            ref.read(searchQueryProvider.notifier).set('');
          }
        },
        onSubmitted: (value) =>
            ref.read(searchQueryProvider.notifier).set(value),
        style: AppTextStyles.body,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Search recipes...',
          hintStyle: AppTextStyles.subtitle,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textSecondary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _recipeSection(BuildContext context, AsyncValue<List<Meals>> meals) {
    return meals.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text('Error: $e', style: AppTextStyles.body),
      ),
      data: (list) {
        if (list.isEmpty) {
          return Center(
            child: Text('Recipe is not available', style: AppTextStyles.body),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < list.length; i += 2)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Expanded(child: _recipeCard(context, list[i])),
                      const SizedBox(width: 12),
                      Expanded(
                        child: i + 1 < list.length
                            ? _recipeCard(context, list[i + 1])
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _recipeCard(BuildContext context, Meals meal) {
    return InkWell(
      onTap: () {
        if (meal.idMeal != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(mealId: meal.idMeal!),
            ),
          );
        }
      },
      child: Card(
        color: AppColors.surface,
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              meal.strMealThumb ?? '',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, size: 50),
              ),
            ),
            Container(
              color: AppColors.surface,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.strMeal ?? '-',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    meal.strCategory ?? '-',
                    style: AppTextStyles.subtitle.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}