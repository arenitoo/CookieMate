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
  final TextEditingController _typeController = TextEditingController();
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Refeição'),
        backgroundColor: Colors.deepPurpleAccent[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cadastre uma nova refeição',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurpleAccent[700],
                ),
              ),
              SizedBox(height: 20),
              _buildInputField(
                controller: _nameController,
                label: 'Nome da Refeição',
                icon: Icons.restaurant_menu,
              ),
              SizedBox(height: 20),
              _buildInputField(
                controller: _typeController,
                label: 'Descrição da Refeição',
                icon: Icons.fastfood,
              ),
              SizedBox(height: 20),
              _buildTimePicker(context),
              SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: _addMeal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Text(
                      'Adicionar Refeição',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurpleAccent,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),
        prefixIcon: Icon(icon, color: Colors.deepPurpleAccent[400]),
        filled: true,
        fillColor: Colors.deepPurple[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    return GestureDetector(
      onTap: _selectTime,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple[50],
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        child: Row(
          children: [
            Icon(Icons.access_time, color: Colors.deepPurpleAccent[400]),
            SizedBox(width: 10),
            Text(
              _selectedTime == null
                  ? 'Escolha um Horário'
                  : 'Horário: ${_selectedTime!.format(context)}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.deepPurpleAccent[700],
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
    if (_nameController.text.isEmpty ||
        _typeController.text.isEmpty ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preencha todos os campos!'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final newMeal = Meal(
      id: DateTime.now().millisecondsSinceEpoch,
      name: _nameController.text,
      time: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      ),
      type: _typeController.text,
    );

    Provider.of<MealProvider>(context, listen: false).addMeal(newMeal);
    Navigator.pop(context);
  }
}

