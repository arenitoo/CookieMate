class Meal {
  final int id;
  final String name;
  final DateTime time;
  final String type; // e.g., Breakfast, Lunch, Dinner

  Meal({required this.id, required this.name, required this.time, required this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time.toIso8601String(),
      'type': type, // Store type in database
    };
  }

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      name: map['name'],
      time: DateTime.parse(map['time']),
      type: map['type'],
    );
  }
}

