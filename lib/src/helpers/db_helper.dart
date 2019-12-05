import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper{

  static Future<Database> database() async{
    final dbPath = await sql.getDatabasesPath();//directorio de la bd
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version){
        db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)'
        );
      },
      version: 1
    );
  }

  static Future<void> insert(String table, Map<String,Object> data) async{
    //con join accedo a la bd especifica
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace //reemplaza si hay un dato en un id ya ingresado
    );
    //db.delete(table);
  }

  static Future<List<Map<String,dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> delete(String id) async{
     final db = await DBHelper.database();
  return db.delete('user_places', where: "id = ?", whereArgs:[id]);
      
}  

}