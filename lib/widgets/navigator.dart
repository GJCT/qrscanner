import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';
class NavigatorBar extends StatelessWidget {
  const NavigatorBar({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectedMenuOpt = i,
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_sharp, size: 30),
            label: 'Mapa'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration_rounded, size: 30),
            label: 'Direcciones'
          ),
      ],

    );
  }
}