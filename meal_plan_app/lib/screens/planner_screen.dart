import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/planner_sheet.dart';
import '../data/recipe_data.dart';
import '../theme.dart';
import 'detail_screen.dart';

class PlannedRecipe {
  final String recipeId;
  String day;
  String mealType;

  PlannedRecipe({
    required this.recipeId,
    required this.day,
    required this.mealType,
  });
}

class PlannerScreen extends StatefulWidget {
  final List<PlannedRecipe> plannedRecipes;

  const PlannerScreen({
    super.key,
    required this.plannedRecipes,
  });

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  static const _mealIcons = {
    'Breakfast': Icons.wb_sunny_outlined,
    'Lunch': Icons.lunch_dining_outlined,
    'Dinner': Icons.nightlight_outlined,
  };

  RecipeData? _findRecipe(String id) {
    for (final recipe in recipeDatas) {
      if (recipe.id == id) {
        return recipe;
      }
    }
    return null;
  }

  // edit hari & meal type lewat bottom sheet
  Future<void> _editRecipe(PlannedRecipe plannedRecipe) async {
    final result = await PlannerSheet.show(
      context,
      title: 'Edit Planner',
      confirmLabel: 'Save Changes',
      initialDay: plannedRecipe.day,
      initialMealType: plannedRecipe.mealType,
      onDelete: () => _removeRecipe(plannedRecipe),
    );

    if (result == null || !mounted) return;

    setState(() {
      plannedRecipe.day = result.day;
      plannedRecipe.mealType = result.mealType;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: Text(
          'Moved to ${result.day} (${result.mealType})',
          style: const TextStyle(color: AppColors.onPrimary),
        ),
      ),
    );
  }

  // hapus planner
  void _removeRecipe(PlannedRecipe plannedRecipe) {
    setState(() {
      widget.plannedRecipes.remove(plannedRecipe);
    });
  }

  // kartu per hari
  Widget _dayCard(String day) {
    final recipesForDay =
        widget.plannedRecipes.where((item) => item.day == day).toList();

    return Card(
      color: AppColors.surface,
      elevation: 2,
      shadowColor: AppColors.primary.withOpacity(0.15),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        iconColor: AppColors.textSecondary,
        collapsedIconColor: AppColors.textSecondary,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        title: Text(
          day,
          style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
        ),
        subtitle: Text(
          recipesForDay.isEmpty
              ? 'Nothing planned'
              : '${recipesForDay.length} recipes',
          style: AppTextStyles.subtitle.copyWith(fontSize: 12),
        ),
        children: [
          for (int i = 0; i < PlannerSheet.mealTypes.length; i++) ...[
            const Divider(height: 1, thickness: 1, color: AppColors.divider),
            _mealSection(
              PlannerSheet.mealTypes[i],
              recipesForDay
                  .where((r) => r.mealType == PlannerSheet.mealTypes[i])
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  // bagian per meal type (Breakfast / Lunch / Dinner)
  Widget _mealSection(String type, List<PlannedRecipe> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Row(
            spacing: 6,
            children: [
              Icon(_mealIcons[type], size: 16, color: AppColors.accent),
              Text(
                type,
                style: AppTextStyles.subtitle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          if (items.isEmpty)
            Text(
              'Nothing planned',
              style: AppTextStyles.subtitle.copyWith(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            for (final item in items) _recipeItem(item),
        ],
      ),
    );
  }

  // card resep
  Widget _recipeItem(PlannedRecipe plannedRecipe) {
    final meal = _findRecipe(plannedRecipe.recipeId);
    if (meal == null) return const SizedBox.shrink();

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(mealId: meal.id),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 6, 10, 6),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                meal.image,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 40,
                  height: 40,
                  color: AppColors.divider,
                  child: const Icon(
                    Icons.restaurant,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                meal.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.cardTitle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            InkWell(
              onTap: () => _editRecipe(plannedRecipe),
              customBorder: const CircleBorder(),
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: AppColors.divider,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  size: 15,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.onPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Plan Your Week',
          style: AppTextStyles.heading.copyWith(
            fontSize: 20,
            color: AppColors.onPrimary,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(15, 16, 15, 8),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Stay healthy, stay organized!',
              style: AppTextStyles.subtitle.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          for (final day in PlannerSheet.days) _dayCard(day),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}