import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "kegelApp.db"),
        onCreate: (db, version) async {
      await db.execute(
          '''CREATE TABELE kegelbruder(name TEXT PRIMARY KEY, pumpe INTEGER, klingeln INTEGER, stina INTEGER, durchwurf INTEGER, handy INTEGER, kugelbringen INTEGER, lustwurf INTEGER, zweiPersonenAufDerBahn INTEGER)''');
    }, version: 1);
  }

  addKegelbruder(newKegelbruder) async {
    final db = await database;

    var res = await db.rawInsert(
        '''INSERT INTO kegelbruder (name, pumpe, klingeln, stina, durchwurf, handy, kugelbringen, lustwurf, zweiPersonenAufDerBahn) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?)''',
        [
          newKegelbruder.name,
          newKegelbruder.pumpe,
          newKegelbruder.klingeln,
          newKegelbruder.stina,
          newKegelbruder.durchwurf,
          newKegelbruder.handy,
          newKegelbruder.kugelbringen,
          newKegelbruder.lustwurf,
          newKegelbruder.zweiPersonenAufDerBahn
        ]);

    return res;
  }
}
