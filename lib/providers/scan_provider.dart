

import 'package:flutter/material.dart';
import 'package:qrscanner/models/scan.dart';
import 'package:qrscanner/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{
  List<ScanModel> scan = [];
  String tipoSelect = 'http';

  nuevoScan(String value) async{
    final nuevoScan = ScanModel(value: value);
    final id = await DbProvider.db.nuevoScanRaw(nuevoScan);
    //Asignar Id
    nuevoScan.id = id;
    
    if(tipoSelect == nuevoScan.type){
      scan.add(nuevoScan);
      notifyListeners();
    }
  }

  cargarScan() async{
    final scans = await DbProvider.db.getTodosLosScans();
    scan = [...scans];
    notifyListeners();
  }

  cargarScanTipo( String type) async{
    final scans = await DbProvider.db.getScanPorTipo(type);
    scan = [...scans];
    tipoSelect = type;
    notifyListeners();
  }

  borrarTodos() async{
    await DbProvider.db.deleteAllScan();
    scan=[];
    notifyListeners();
  }

  borrarScanById( int id) async{
    await DbProvider.db.deleteScan(id);
    
  }
}