import 'package:flutter/material.dart';
import './screens/main-activity.dart';

void main() => runApp(PokedexApp());

class PokedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //theme: darkTheme(),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Colors.red,
              secondary: Colors.red, // Esta é geralmente a cor do accentColor
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //themeMode: ThemeMode.dark, // Força o aplicativo a usar o tema escuro
      home: HomePage(),
    );
  }
}
