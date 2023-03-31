import 'dart:io';

import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:qrscanner/models/scan.dart';
import 'package:sqflite/sqflite.dart';
export 'package:qrscanner/providers/db_provider.dart';

class DbProvider{
  static late Database _database;
  static final DbProvider db = DbProvider._();
  DbProvider._();

  Future<Database> get database async{

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async{
    //Path para almacenamiento
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    //Path numerico
    final path = join(documentDirectory.path, 'ScanDB.db');
    print(path);
    //Crear BD
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async{
        await db.execute('''
          CREATE TABLE scan(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
        ''');
      },
    );
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async{

    final id   = nuevoScan.id;
    final type = nuevoScan.type;
    final value= nuevoScan.value;

    //Verificación
    final db = await database;

    //Insert
    final res = db.rawInsert('''
      INSERT INTO Scan(id, type, value) 
        VALUES($id, '$type', '$value')
    ''');
    return res;
  }

  //Future<int> nuevoScan(ScanModel nuevoScan) async{
  //  final db = await database;
  //  final res = await db.insert('Scans', nuevoScan.toJson());
  //  return res;
  //}

  Future <ScanModel?> getScanById(int id) async{
    final db = await database;
    final res= await db.query('Scan', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null; 
  }
  
  
  Future <List<ScanModel>> getTodosLosScans() async{
    final db = await database;
    final res= await db.query('Scan');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future <List<ScanModel>> getScanPorTipo(String type) async{

    final db  = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scan WHERE type = '$type' 
    ''');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int> updateScan(ScanModel nuevoScan) async{
    final db  = await database;
    final res = await db.update('Scan', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;
  }

  Future<int> deleteScan(int id) async{
    final db  = await database;
    final res = await db.delete('Scan', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteAllScan() async{
    final db  = await database;
    final res = await db.delete('Scan');

    return res;
  }
}