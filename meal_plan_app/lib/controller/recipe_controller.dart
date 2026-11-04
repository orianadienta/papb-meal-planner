// import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recipe_model.dart';
import '../services/meal_api.dart';

final mealApiProvider = Provider((ref) => MealApi());

// search state
class SearchQuery extends Notifier<String> {
  @override
  String build() => '';
  void set(String q) => state = q.trim();
}

final searchQueryProvider = NotifierProvider<SearchQuery, String>(SearchQuery.new);

// daftar resep state
final mealListProvider = FutureProvider<List<Meals>>((ref) async {
  final api = ref.watch(mealApiProvider);
  final query = ref.watch(searchQueryProvider);

  final response = query.isEmpty
      ? await api.fetchMealsByLetter('a')
      : await api.fetchMealsBySearch(query);
  return response.meals ?? [];

});

//detail resep state 
final mealDetailProvider = FutureProvider.family<Meals?, String>((ref, id) async {
  final response = await ref.watch(mealApiProvider).fetchMealDetails(id);
  return response.meals?.firstOrNull;
});