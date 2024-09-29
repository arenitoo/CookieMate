import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mealmate/data/models/meal_model.dart';
import 'package:mealmate/presentation/providers/meal_provider.dart';

class AddMealPage extends StatefulWidget {
  @override
  _AddMealPageState createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  final TextEditingController _nameController = TextEditingController();
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Refeição'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome da Refeição',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  _selectedTime == null
                      ? 'Selecione o Horário'
                      : 'Horário: ${_selectedTime!.format(context)}',
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: _selectTime,
                  child: Text('Escolher Horário'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addMeal,
              child: Text('Adicionar Refeição'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _addMeal() {
    if (_nameController.text.isEmpty || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos!')),
      );
      return;
    }

    final newMeal = Meal(
      id: DateTime.now().millisecondsSinceEpoch, // ID temporário
      name: _nameController.text,
      time: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      ),
    );

    Provider.of<MealProvider>(context, listen: false).addMeal(newMeal);
    Navigator.pop(context);
  }
}
