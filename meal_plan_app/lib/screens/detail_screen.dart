import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/recipe_controller.dart';
import '../models/recipe_model.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/planner_sheet.dart';
import '../data/planner_data.dart';
import '../screens/planner_screen.dart';
import '../theme.dart';

class DetailScreen extends ConsumerWidget {
  final String mealId;

  const DetailScreen({
    super.key,
    required this.mealId,
  });

  Future<void> _addToPlanner(BuildContext context, Meals meal) async {
    final result = await PlannerSheet.show(
      context,
      title: 'Add to Planner',
      confirmLabel: 'Add to Planner',
    );

    if (result == null || !context.mounted) return;

    plannedRecipes.add(
      PlannedRecipe(
        recipeId: meal.idMeal ?? '',
        day: result.day,
        mealType: result.mealType,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: Text(
          'Added recipe to ${result.day}',
          style: const TextStyle(color: AppColors.onPrimary),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(mealDetailProvider(mealId));

    return detail.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Error: $e')),
      ),
      data: (meal) => meal == null
          ? Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text('Recipe not found')),
            )
          : _buildDetail(context, meal),
    );
  }

  Widget _buildDetail(BuildContext context, Meals meal) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(3, 2, 3, 2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      meal.strMealThumb ?? '',
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 300,
                          color: AppColors.divider,
                          child: Icon(
                            Icons.restaurant,
                            size: 60,
                            color: AppColors.textSecondary,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 40,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: AppColors.white,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // detail resep
                Transform.translate(
                  offset: const Offset(0, -25),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  meal.strMeal ?? '',
                                  style: AppTextStyles.cardTitle.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                onPressed: () => _addToPlanner(context, meal),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,   
                                  foregroundColor: AppColors.onPrimary,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                                label: Text(
                                  'Add to Planner',
                                  style: AppTextStyles.button.copyWith(
                                    fontSize: 14,
                                    color: AppColors.onPrimary, 
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                    meal.strCategory ?? '',
                                    style: AppTextStyles.subtitle,
                              ),
                              
                              Divider(
                                height: 20,
                                color: AppColors.divider,
                                thickness: 1,
                              ),
                            ],
                          ),
                          

                          // Ingredients
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ingredients',
                                style: AppTextStyles.cardTitle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              for (final ingredient in meal.ingredients)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    ingredient,
                                    style: AppTextStyles.body.copyWith(
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              Divider(
                                height: 20,
                                color: AppColors.divider,
                                thickness: 1,
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                            'Instructions',
                            style: AppTextStyles.cardTitle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            meal.strInstructions ?? '',
                            style: AppTextStyles.body.copyWith(
                              height: 1.5,
                            ),
                          ),
                          ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}