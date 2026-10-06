import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../models/recipe_model.dart';

class MealApi {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<RecipeModel> fetchMeals(String type) async {
    final response = await http.get(Uri.parse("$_baseUrl/filter.php?c=$type"));
    if (response.statusCode == 200) {
      return RecipeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load meals');
    }
  }

  Future<RecipeModel> fetchMealsByLetter(String letter) async {
    final response = await http.get(Uri.parse("$_baseUrl/search.php?f=$letter"));
    if (response.statusCode == 200) {
      return RecipeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load meals');
    }
  }

  Future<RecipeModel> fetchMealDetails(String mealId) async {
    final response = await http.get(Uri.parse("$_baseUrl/lookup.php?i=$mealId"));
    if (response.statusCode == 200) {
      return RecipeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load meal details');
    }
  }

  Future<RecipeModel> fetchMealsBySearch(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search.php?s=$query"));
    if (response.statusCode == 200) {
      return RecipeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load meals by search');
    }
  }
}