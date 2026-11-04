class FilterMealModel {
  List<Meals>? meals;

  FilterMealModel({this.meals});

  FilterMealModel.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(new Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meals != null) {
      data['meals'] = this.meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meals {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;
  String? strArea;
  String? strCountry;

  Meals(
      {this.strMeal,
      this.strMealThumb,
      this.idMeal,
      this.strArea,
      this.strCountry});

  Meals.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
    strArea = json['strArea'];
    strCountry = json['strCountry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strMeal'] = this.strMeal;
    data['strMealThumb'] = this.strMealThumb;
    data['idMeal'] = this.idMeal;
    data['strArea'] = this.strArea;
    data['strCountry'] = this.strCountry;
    return data;
  }
}
