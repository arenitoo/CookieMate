import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mealmate/presentation/providers/meal_provider.dart';
import 'package:mealmate/presentation/pages/add_meal_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MealMate'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suas Refeições de Hoje',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<MealProvider>(
                builder: (context, mealProvider, child) {
                  return ListView.builder(
                    itemCount: mealProvider.meals.length,
                    itemBuilder: (context, index) {
                      final meal = mealProvider.meals[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.restaurant),
                          title: Text(meal.name),
                          subtitle: Text('Horário: ${meal.time.hour}:${meal.time.minute}'),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Função para detalhes da refeição
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
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
}
