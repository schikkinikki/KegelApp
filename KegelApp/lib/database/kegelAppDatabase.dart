import 'package:KegelApp/models/kegelbruder.dart';
import 'package:KegelApp/models/session.dart';
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
      await db.execute(
          '''CREATE TABLE session(date TEXT, name TEXT PRIMARY KEY, pumpe INTEGER, klingeln INTEGER, stina INTEGER, durchwurf INTEGER, handy INTEGER, kugelbringen INTEGER, lustwurf INTEGER, zweiPersonenAufDerBahn INTEGER)''');
    }, version: 1);
  }

  //adding a new entry to kegelbruder table
  addKegelbruder(Kegelbruder newKegelbruder) async {
    final db = await database;
    var res = await db.insert("kegelbruder", newKegelbruder.toMap());
    return res;
  }

  //adding a new entry to session table
  addSession(Session newSession) async {
    final db = await database;
    var res = await db.insert("session", newSession.toMap());
    return res;
  }

  //getting a entry from kegelbruder table
  Future<dynamic> getKegelbruder(String name) async {
    final db = await database;
    var res =
        await db.query("kegelbruder", where: "name = ?", whereArgs: [name]);
    return res.isNotEmpty ? Kegelbruder.fromMap(res.first) : null;
  }

  //getting selected player entry kegelbruder table
  Future<dynamic> getSelectedKegelbruder() async {
    final db = await database;
    var res = await db.query("kegelbruder", where: "isSelected = 1");
    return res.isNotEmpty ? Kegelbruder.fromMap(res.first) : null;
  }

  //getting all entrys from kegelbruder table
  Future<List<Kegelbruder>> getAllKegelbruder() async {
    final db = await database;
    var res = await db.query("kegelbruder");
    List<Kegelbruder> list =
        res.isNotEmpty ? res.map((e) => Kegelbruder.fromMap(e)).toList() : [];
    return list;
  }

  //getting all entrys from session table
  Future<List<Session>> getAllSessions() async {
    final db = await database;
    var res = await db.query("session");
    List<Session> list =
        res.isNotEmpty ? res.map((e) => Session.fromMap(e)).toList() : [];
    return list;
  }

  //delete a entry from kegelbruder table
  deleteKegelbruder(String name) async {
    final db = await database;
    await db.delete("kegelbruder", where: "name = ?", whereArgs: [name]);
  }

  //update a entry from kegelbruder table
  updateKegelbruder(Kegelbruder kegelbruder) async {
    final db = await database;
    Kegelbruder updateBruder = Kegelbruder(
        name: kegelbruder.name,
        pumpe: kegelbruder.pumpe,
        klingeln: kegelbruder.klingeln,
        stina: kegelbruder.stina,
        durchwurf: kegelbruder.durchwurf,
        handy: kegelbruder.handy,
        kugelBringen: kegelbruder.kugelBringen,
        lustwurf: kegelbruder.lustwurf,
        zweiPersonenAufDerBahn: kegelbruder.zweiPersonenAufDerBahn,
        isSelected: kegelbruder.isSelected);
    var res = await db.update("kegelbruder", updateBruder.toMap(),
        where: "name = ?", whereArgs: [kegelbruder.name]);
    return res;
  }
}
