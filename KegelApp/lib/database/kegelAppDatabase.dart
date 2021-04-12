import 'package:KegelApp/models/kegelbruder.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  // create Database instance
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  //creates database plus table
  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "kegelApp.db"),
        onCreate: (db, version) async {
      await db.execute(
          '''CREATE TABELE kegelbruder(name TEXT PRIMARY KEY, pumpe INTEGER, klingeln INTEGER, stina INTEGER, durchwurf INTEGER, handy INTEGER, kugelbringen INTEGER, lustwurf INTEGER, zweiPersonenAufDerBahn INTEGER)''');
    }, version: 1);
  }

  //adding a new entrie to the database
  addKegelbruder(Kegelbruder newKegelbruder) async {
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
          newKegelbruder.kugelBringen,
          newKegelbruder.lustwurf,
          newKegelbruder.zweiPersonenAufDerBahn
        ]);
    return res;
  }

  //getting a entrie from the database
  Future<dynamic> getKegelbruder() async {
    final db = await database;
    var res = await db.query("kegelbruder");
    if (res.length == 0) {
      return null;
    } else {
      var resMap = res[0];
      return resMap.isEmpty ? resMap : null;
    }
  }

  //delete a entrie from the database
  deleteKegelbruder(String name) async {
    final db = await database;
    await db.delete("kegelbruder", where: "name = ?", whereArgs: [name]);
  }

  //update a entrie from the database
  updateKegelbruder(Kegelbruder kegelbruder) async {
    final db = await database;
    var res = await db.update("kegelbruder", kegelbruder.toMap(),
        where: "name", whereArgs: [kegelbruder.name]);
    return res;
  }
}
