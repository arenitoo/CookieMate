class Meal {
  int id;
  String name;
  DateTime time;

  Meal({required this.id, required this.name, required this.time});

  // Método para converter a refeição em um mapa (usado pelo SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time.toIso8601String(),
    };
  }

  // Método para criar uma refeição a partir de um mapa (usado pelo SQLite)
  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      name: map['name'],
      time: DateTime.parse(map['time']),
    );
  }
}
