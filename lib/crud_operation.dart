import 'package:actividad6_final/recordatorios_view.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteProvider {
  static Database db;

  static Future open() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        db.execute('''
          create table Notes(
            id integer primary key autoincrement,
            title text not null,
            text text not null,
            Num int null,
            Hours int not null,
            Minutes int not null,
            Seconds int not null
          );
        ''');
      }
    );
  }

  /*EQUIVALENTE A SELECT LIKE
   static Future<List>Busqueda()async{
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM Notes WHERE");
    List notas = [];
    print(maps);
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        notas.add(NoteListState/*.fromMap(maps[i])*/);
      }
    }
    return notas;
  }*/

  static Future<List<Map<String, dynamic>>> getNoteList() async {
    if (db == null) {
      await open();
    }
    return await db.query('Notes');
  }

  static Future insertNote(Map<String, dynamic> note) async {
    await db.insert('Notes', note);
  }

  static Future updateNote(Map<String, dynamic> note) async {
    await db.update(
      'Notes',
      note,
      where: 'id = ?',
      whereArgs: [note['id']]);
  }

  static Future deleteNote(int id) async {
    await db.delete(
      'Notes',
      where: 'id = ?',
      whereArgs: [id]);
  } 
}