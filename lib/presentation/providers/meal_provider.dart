import 'package:flutter/material.dart';
import 'package:mealmate/data/models/meal_model.dart';
import 'package:mealmate/data/repositories/meal_repository.dart';
import 'package:mealmate/services/notification_service.dart';

class MealProvider with ChangeNotifier {
  final MealRepository _mealRepository = MealRepository();
  final NotificationService _notificationService = NotificationService();
  List<Meal> _meals = [];

  List<Meal> get meals => _meals;

  MealProvider() {
    _loadMeals();
    _notificationService.initNotifications();
  }

  // Carregar refeições do repositório
  Future<void> _loadMeals() async {
    try {
      _meals = await _mealRepository.getMeals();
      notifyListeners();
    } catch (e) {
      // Trate o erro (por exemplo, mostrar um SnackBar ou logar o erro)
      print('Erro ao carregar refeições: $e');
    }
  }

  // Adicionar uma nova refeição e agendar a notificação
  Future<void> addMeal(Meal meal) async {
    await _mealRepository.insertMeal(meal);
    _meals.add(meal);
    notifyListeners();
    print('Refeições cadastradas: $_meals');
    await _scheduleMealNotification(meal);
  }

  // Remover uma refeição e cancelar a notificação
  Future<void> removeMeal(int id) async {
    await _mealRepository.deleteMeal(id);
    _meals.removeWhere((meal) => meal.id == id);
    notifyListeners();
    await _cancelMealNotification(id);
  }

  // Método para agendar a notificação de uma refeição
  Future<void> _scheduleMealNotification(Meal meal) async {
    final DateTime now = DateTime.now();
    DateTime mealTime = DateTime(now.year, now.month, now.day, meal.time.hour, meal.time.minute);

    // Se a hora da refeição já passou hoje, agendar para o próximo dia
    if (mealTime.isBefore(now)) {
      mealTime = mealTime.add(Duration(days: 1));
    }

    await _notificationService.scheduleNotification(
      meal.id, 
      'Hora de ${meal.name}', 
      'Está na hora de sua ${meal.name}!', 
      mealTime,
    );
  }

  // Método para cancelar a notificação de uma refeição
  Future<void> _cancelMealNotification(int mealId) async {
    await _notificationService.flutterLocalNotificationsPlugin.cancel(mealId);
  }
}

