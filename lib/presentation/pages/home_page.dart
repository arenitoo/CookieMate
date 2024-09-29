import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mealmate/presentation/providers/meal_provider.dart';
import 'package:mealmate/presentation/pages/add_meal_page.dart';
import 'package:mealmate/presentation/pages/meal_detail_page.dart';
import 'package:mealmate/data/models/meal_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CookieMate',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent[400],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suas Refeições de Hoje',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple[900],
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<MealProvider>(
                builder: (context, mealProvider, child) {
                  if (mealProvider.meals.isEmpty) {
                    return Center(
                      child: Text(
                        'Nenhuma refeição cadastrada.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: mealProvider.meals.length,
                    itemBuilder: (context, index) {
                      final meal = mealProvider.meals[index];
                      return _buildMealTile(meal, context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent[400],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMealPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildMealTile(Meal meal, BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(Icons.restaurant, color: Colors.deepPurpleAccent[400]),
        title: Text(
          meal.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurpleAccent[400],
          ),
        ),
        subtitle: Text(
          'Horário: ${meal.time.hour}:${meal.time.minute}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurpleAccent[400]),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealDetailPage(meal: meal),
            ),
          );
        },
      ),
    );
  }
}
