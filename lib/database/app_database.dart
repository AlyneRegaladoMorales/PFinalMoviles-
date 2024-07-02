import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:super_comics_app/models/superhero.dart';

class AppDatabase{
  final int version = 1;
  final String databaseName = "superheros.db";
  final String tableName = "superheroes";
  Database? db;

  Future<Database> openDb() async {
    db ??= await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
      onCreate: (db, version) {
        String query = '''
          CREATE TABLE $tableName (
            id TEXT PRIMARY KEY,
            name TEXT,
            gender TEXT,
            intelligence TEXT,
            image TEXT
          )
        ''';
        db.execute(query);
      },
    );
    return db!;
  }

  Future<int> insertSuperHero(SuperHero hero) async {
 
    print('Saving APPfavorite: ${hero.id}');
    print('Saving APPname: ${hero.name}');
    print('Saving APPgender: ${hero.gender}');
    print('Saving APPintelligence: ${hero.intelligence}');
    
    Database database = await openDb();
    print('OPEN DATA');
    return await database.insert(
      tableName, 
      hero.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      
      );
  }

  Future<int> deleteSuperHero(String id) async {
    Database database = await openDb();
    return await database.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<List<SuperHero>> fetchAllSuperHeroes() async {
    Database database = await openDb();
    final List<Map<String, dynamic>> maps = await database.query('superheroes');

    return List.generate(maps.length, (i) {
      return SuperHero(
        id: maps[i]['id'],
        name: maps[i]['name'],
        gender: maps[i]['gender'],
        intelligence: maps[i]['intelligence'],
        image: maps[i]['image'],
      );
    });
  }
}