import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/pages/direction_pages.dart';
import 'package:qrscanner/pages/maps_page.dart';
import 'package:qrscanner/providers/scan_provider.dart';
import 'package:qrscanner/providers/ui_provider.dart';
import 'package:qrscanner/widgets/bottom.dart';
import 'package:qrscanner/widgets/navigator.dart';

class HomePage extends StatelessWidget {
   
  const HomePage({key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever_rounded, size: 35),
            onPressed: (){
              Provider.of<ScanListProvider>(context, listen: false).borrarTodos();
            }
          )
        ],
      ),
      body: const _HomePageBody(),

      bottomNavigationBar: const NavigatorBar(),
      //Botton
      floatingActionButton: const ScanBottom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {
    //Obtener el current
    final uiProvider = Provider.of<UiProvider>(context);

    //Cambiar de página
    final currentIndex = uiProvider.selectedMenuOpt;

    //Usar el Scan
    final scanProvider = Provider.of<ScanListProvider>(context, listen: false);
    
    switch (currentIndex) {
      case 0:
      scanProvider.cargarScanTipo('geo');
        return const MapsPage();
      case 1:
      scanProvider.cargarScanTipo('http');
        return const DirectionPage();
      default:
        return const MapsPage();
    }
  }
}