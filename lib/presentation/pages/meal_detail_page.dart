import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mealmate/data/models/meal_model.dart';
import 'package:mealmate/presentation/providers/meal_provider.dart';

class MealDetailPage extends StatelessWidget {
  final Meal meal;

  const MealDetailPage({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Refeição'),
        backgroundColor: Colors.deepPurpleAccent[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailCard(context),
            SizedBox(height: 40),
            _buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

Widget _buildDetailCard(BuildContext context) {
  return Card(
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meal.name,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent[700],
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.deepPurpleAccent[400]),
              SizedBox(width: 10),
              Expanded( // Use Expanded para permitir que o texto ocupe o espaço
                child: Text(
                  'Horário: ${meal.time.hour}:${meal.time.minute}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.fastfood, color: Colors.deepPurpleAccent[400]),
              SizedBox(width: 10),
              Expanded( // Use Expanded para permitir que o texto ocupe o espaço
                child: Text(
                  'Descrição: ${meal.type}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}



  Widget _buildDeleteButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _confirmDelete(context, meal);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
          child: Text(
            'Excluir Refeição',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.redAccent,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
        ),
      ),
    );
  }

  // Diálogo de confirmação para excluir
  void _confirmDelete(BuildContext context, Meal meal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Excluir Refeição',
          style: TextStyle(color: Colors.redAccent),
        ),
        content: Text('Tem certeza de que deseja excluir esta refeição?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fechar diálogo
            },
            child: Text('Cancelar'),
            style: TextButton.styleFrom(
              primary: Colors.deepPurpleAccent[400],
            ),
          ),
          TextButton(
            onPressed: () {
              Provider.of<MealProvider>(context, listen: false).removeMeal(meal.id);
              Navigator.pop(context); // Fechar o diálogo
              Navigator.pop(context); // Voltar à tela anterior
            },
            child: Text('Excluir'),
            style: TextButton.styleFrom(
              primary: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
