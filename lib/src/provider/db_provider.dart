import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_list/src/models/actividad_model.dart';


class DBProvider {

  static Database? _database;
  static final DBProvider db = DBProvider._();
 
  DBProvider._();
 
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async{

    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'actividadesDb.db' );
    print( path );

    // Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) { },
      onCreate: ( Database db, int version ) async {

        await db.execute('''
          CREATE TABLE actividades(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT,
            descripcion TEXT,
            activa INTEGER
          )
        ''');
      }
    );

  }


  Future<int?> nuevaActividad( ActividadModel actividad ) async {

    final db = await database;
    
    final res = await db!.insert('actividades', actividad.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);

    return res;
    
     }

  Future<List<ActividadModel>> getTodosLosActividades() async {

    final db  = await database;
    final res = await db?.query('actividades');

    return res!.isNotEmpty
          ? res.map( (s) => ActividadModel.fromJson(s) ).toList()
          : [];
  } 

  Future<List<ActividadModel>> buscarDescripcion(String d) async {
    d = d + "%";
    final db  = await database;
    final res = await db?.query("actividades", where: "descripcion LIKE ?", whereArgs:[d]); 

    return res!.isNotEmpty
          ? res.map( (s) => ActividadModel.fromJson(s) ).toList()
          : [];
  } 

  



  Future<int> updateActividad( ActividadModel actividad ) async {
    final db  = await database;
    final res = await db!.update('actividades', actividad.toJson(), where: 'id = ?', whereArgs: [ actividad.id ] );
    return res;
  }

  Future<int> deleteActividad( int id ) async {
    final db  = await database;
    final res = await db!.delete( 'actividades', where: 'id = ?', whereArgs: [id] );
    return res;
  }

  Future<int> deleteAllActividades() async {
    final db  = await database;
    final res = await db!.rawDelete('''
      DELETE FROM actividades    
    ''');
    return res;
  }


}
