import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'notificacion.dart';
import 'package:path/path.dart';


//CLASE DE LA BASE DE DATOS
class DBHelper {
  static Database _db;
  //CAMPOS DE LA TABLA
  static const String Id = 'id';
  static const String title = 'title';
  static const String description = 'description';
  //NOMBRE DE LA TABLA
  static const String TABLE = 'Notificaciones';
  //NOMBRE DE LA BASE DE DATOS
  static const String DB_NAME = 'notificaciones.db';


  //CREACION DE LA BASE DE DATOS (VERIFICAR EXISTENCIA)
  Future<Database> get db async {
    //SI ES DIFERENTE DE NULL RETORNARÁ LA BASE DE DATOS
    if (_db != null) {
      return _db;
    } else {
      //SI NO VAMOS A CREAR EL METODO
      _db = await initDb();
      return _db;
    }
  }

  //DATABASE CREATION
  initDb() async {
    //VARIABLE PARA RUTA DE LOS ARCHIVOS DE LA APLICACION
    io.Directory appDirectory = await getApplicationDocumentsDirectory();
    print(appDirectory);
    String path = join(appDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE $TABLE ($Id INTEGER PRIMARY KEY, $title TEXT, $description TEXT)");
  }

    //EQUIVALENTE A SELECT
  Future<List<Notificacion>> getNotificacion() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [Id, title, description]);
    List<Notificacion> noti = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        noti.add(Notificacion.fromMap(maps[i]));
      }
    }
    return noti;
  }

  //EQUIVALENTE A SELECT LIKE
  Future<List<Notificacion>>Busqueda(String buscado) async{
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE WHERE $title LIKE '$buscado%'");
    List<Notificacion> noti = [];
    print(maps);
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        noti.add(Notificacion.fromMap(maps[i]));
      }
    }
    return noti;
  }

  //EQUIVALENTE A SAVE O INSERT
  Future<bool> ValidarInsert(Notificacion notificacion) async {
    var dbClient = await db;
    var check = notificacion.title;
    List<Map> maps = await dbClient
        .rawQuery("select $Id from $TABLE where $title = $check");
    if (maps.length == 0) {
      return true;
    }else{
      return false;
    }
  }
  Future<bool> insert(Notificacion notificacion) async {
    var dbClient = await db;
    notificacion.id = await dbClient.insert(TABLE, notificacion.toMap());
  }

  //EQUIVALENTE A DELETE
  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$Id = ?', whereArgs: [id]);
  }

  //EQUIVALENTE A UPDATE
  Future<int> update(Notificacion notificacion) async{
    var dbClient = await db;
    return await dbClient.update(TABLE, notificacion.toMap(),
        where: '$Id = ?', whereArgs: [notificacion.id]);
  }

  //CLOSE DATABASE
  Future closedb()async{
    var dbClient = await db;
    dbClient.close();
  }
}


