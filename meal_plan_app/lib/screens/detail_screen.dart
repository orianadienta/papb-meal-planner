
import 'package:flutter/material.dart';

import '../models/recipe_model.dart';
import '../services/meal_api.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../theme.dart';

class DetailScreen extends StatefulWidget {
  final String mealId;

  const DetailScreen({
    super.key,
    required this.mealId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<RecipeModel> mealFuture;

  @override
  void initState() {
    super.initState();
    mealFuture = MealApi().fetchMealDetails(widget.mealId);
  }

  // Mengambil ingredients dan measure dari model API.
  List<Map<String, String>> getIngredients(Meals meal) {
    final ingredients = [
      meal.strIngredient1,
      meal.strIngredient2,
      meal.strIngredient3,
      meal.strIngredient4,
      meal.strIngredient5,
      meal.strIngredient6,
      meal.strIngredient7,
      meal.strIngredient8,
      meal.strIngredient9,
      meal.strIngredient10,
      meal.strIngredient11,
      meal.strIngredient12,
      meal.strIngredient13,
      meal.strIngredient14,
      meal.strIngredient15,
      meal.strIngredient16,
      meal.strIngredient17,
      meal.strIngredient18,
      meal.strIngredient19,
      meal.strIngredient20,
    ];

    final measures = [
      meal.strMeasure1,
      meal.strMeasure2,
      meal.strMeasure3,
      meal.strMeasure4,
      meal.strMeasure5,
      meal.strMeasure6,
      meal.strMeasure7,
      meal.strMeasure8,
      meal.strMeasure9,
      meal.strMeasure10,
      meal.strMeasure11,
      meal.strMeasure12,
      meal.strMeasure13,
      meal.strMeasure14,
      meal.strMeasure15,
      meal.strMeasure16,
      meal.strMeasure17,
      meal.strMeasure18,
      meal.strMeasure19,
      meal.strMeasure20,
    ];

    final result = <Map<String, String>>[];

    for (int i = 0; i < ingredients.length; i++) {
      final ingredient = ingredients[i]?.trim() ?? '';

      if (ingredient.isEmpty) continue;

      final measure = measures[i]?.trim() ?? '';

      result.add({
        'ingredient': ingredient,
        'measure': measure,
      });
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // Jarak luar sangat tipis.
      body: Padding(
        padding: const EdgeInsets.fromLTRB(3, 2, 3, 2),
        child: FutureBuilder<RecipeModel>(
          future: mealFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Gagal memuat detail resep',
                  style: AppTextStyles.body,
                ),
              );
            }

            if (!snapshot.hasData ||
                snapshot.data!.meals == null ||
                snapshot.data!.meals!.isEmpty) {
              return Center(
                child: Text(
                  'Data resep tidak ditemukan',
                  style: AppTextStyles.body,
                ),
              );
            }

            final meal = snapshot.data!.meals!.first;
            final ingredients = getIngredients(meal);

            return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // GAMBAR RESEP + TOMBOL KEMBALI
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
                              color: Colors.grey.shade300,
                              child: Icon(
                                Icons.restaurant,
                                size: 60,
                                color: AppColors.textPrimary,
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

                    // KONTEN DETAIL RESEP
                    // Kartu naik 25 px untuk menimpa bagian bawah gambar.
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
                              // JUDUL RESEP + TOMBOL PLANNER
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      meal.strMeal ?? 'Nama resep',
                                      style: AppTextStyles.cardTitle.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.textPrimary,
                                      foregroundColor: AppColors.accent,
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
                                      'Add to planner',
                                      style: AppTextStyles.button.copyWith(
                                        fontSize: 12,
                                        color: AppColors.accent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // INGREDIENTS
                              Text(
                                'Ingredients',
                                style: AppTextStyles.cardTitle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 12),

                              if (ingredients.isEmpty)
                                Text(
                                  'Bahan tidak tersedia',
                                  style: AppTextStyles.body,
                                )
                              else
                                ...ingredients.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Bullet sejajar dengan baris pertama teks bahan
                                        SizedBox(
                                          width: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 7),
                                            child: Center(
                                              child: Container(
                                                width: 7,
                                                height: 7,
                                                decoration: const BoxDecoration(
                                                  color: AppColors.textPrimary,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 10),

                                        // Nama bahan
                                        Expanded(
                                          child: Text(
                                            item['ingredient']!,
                                            style: AppTextStyles.body.copyWith(
                                              height: 1.4,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 12),

                                        // Takaran di sebelah kanan
                                        SizedBox(
                                          width: 110,
                                          child: Text(
                                            item['measure']!.isEmpty ? '-' : item['measure']!,
                                            textAlign: TextAlign.end,
                                            style: AppTextStyles.subtitle.copyWith(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),

                              const SizedBox(height: 24),

                              // INSTRUCTIONS
                              Text(
                                'Instructions',
                                style: AppTextStyles.cardTitle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                (meal.strInstructions ?? '').trim().isEmpty
                                    ? 'Instruksi tidak tersedia'
                                    : meal.strInstructions!.trim(),
                                style: AppTextStyles.body,
                              ),

                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}


