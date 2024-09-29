import 'package:flutter/material.dart';
import 'package:mealmate/data/models/meal_model.dart';
import 'package:mealmate/data/repositories/meal_repository.dart';

class MealProvider with ChangeNotifier {
  final MealRepository _mealRepository = MealRepository();
  List<Meal> _meals = [];

  List<Meal> get meals => _meals;

  MealProvider() {
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    _meals = await _mealRepository.getMeals();
    notifyListeners();
  }

  Future<void> addMeal(Meal meal) async {
    await _mealRepository.insertMeal(meal);
    _meals.add(meal);
    notifyListeners();
  }

  Future<void> removeMeal(int id) async {
    await _mealRepository.deleteMeal(id);
    _meals.removeWhere((meal) => meal.id == id);
    notifyListeners();
  }
}

