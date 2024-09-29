import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mealmate/data/models/meal_model.dart';

class MealRepository {
  static Database? _database;

  Future<void> deleteDatabase(String path) async {
    String path = join(await getDatabasesPath(), 'meal_database.db');
    await deleteDatabase(path); // Isso excluirá o banco de dados antigo
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

 Future<Database> _initDB() async {
  String path = join(await getDatabasesPath(), 'meal_database.db');
  return await openDatabase(
    path,
    version: 2, // Atualize para uma nova versão
    onCreate: (db, version) async {
      // Criação inicial do banco de dados
      await db.execute('''
        CREATE TABLE meals (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          time TEXT,
          type TEXT
        )
      ''');
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        // Migração: adiciona a coluna "type" se o banco de dados já existir
        await db.execute('ALTER TABLE meals ADD COLUMN type TEXT');
      }
    },
  );
}

  Future<void> insertMeal(Meal meal) async {
    final db = await database;
    await db.insert('meals', meal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Meal>> getMeals() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('meals');

    return List.generate(maps.length, (i) {
      return Meal.fromMap(maps[i]);
    });
  }

  Future<void> deleteMeal(int id) async {
    final db = await database;
    await db.delete('meals', where: 'id = ?', whereArgs: [id]);
  }
}
