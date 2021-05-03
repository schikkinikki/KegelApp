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
          '''CREATE TABLE kegelbruder(name TEXT PRIMARY KEY, pumpe INTEGER, klingeln INTEGER, stina INTEGER, durchwurf INTEGER, handy INTEGER, kugelbringen INTEGER, lustwurf INTEGER, zweiPersonenAufDerBahn INTEGER, isSelected INTEGER)''');
    }, version: 1);
  }

  //adding a new entrys to the database
  addKegelbruder(Kegelbruder newKegelbruder) async {
    final db = await database;
    var res = await db.insert("kegelbruder", newKegelbruder.toMap());
    return res;
  }

  //getting a entrys from the database
  Future<dynamic> getKegelbruder(String name) async {
    final db = await database;
    var res =
        await db.query("kegelbruder", where: "name = ?", whereArgs: [name]);
    return res.isNotEmpty ? Kegelbruder.fromMap(res.first) : null;
  }

  //getting all entrys from the database
  Future<List<Kegelbruder>> getAllKegelbruder() async {
    final db = await database;
    var res = await db.query("kegelbruder");
    List<Kegelbruder> list =
        res.isNotEmpty ? res.map((e) => Kegelbruder.fromMap(e)).toList() : [];
    return list;
  }

  //delete a entry from the database
  deleteKegelbruder(String name) async {
    final db = await database;
    await db.delete("kegelbruder", where: "name = ?", whereArgs: [name]);
  }

  //update a entry from the database
  updateKegelbruder(Kegelbruder kegelbruder) async {
    final db = await database;
    var res = await db.update("kegelbruder", kegelbruder.toMap(),
        where: "name", whereArgs: [kegelbruder.name]);
    return res;
  }

  //update selection
  updateKegelbruderSelection(Kegelbruder kegelbruder) async {
    final db = await database;
    var res = await db.rawUpdate(
        "UPDATE kegelbruder SET isSelected = ? WHERE name = ?"[
            kegelbruder.isSelected],
        [kegelbruder.name.toString()]);
    return res;
  }
}
