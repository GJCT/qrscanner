import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/pages/home_page.dart';
import 'package:qrscanner/pages/map_page.dart';
import 'package:qrscanner/providers/scan_provider.dart';
import 'package:qrscanner/providers/ui_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ( _) => UiProvider()
        ),
        ChangeNotifierProvider(
          create: ( _) => ScanListProvider()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': ( _) => const HomePage(),
          'maps': ( _) => const MapPage()
        },
        theme: ThemeData(
          primaryColor: Colors.green,
          appBarTheme: const AppBarTheme(color: Colors.green),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.green
          )
        ),
      ),
    );
  }
}