import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Pokemon.dart';
import './details.dart';
import 'dart:convert';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Pokemon> favoritePokemons = [];

  @override
  void initState() {
    super.initState();
    _loadFavoritePokemons();
  }

  _loadFavoritePokemons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Pokemon> loadedFavorites = [];
    for (int i = 1; i <= 151; i++) {
      bool isFavorite = prefs.getBool('favorite_$i') ?? false;
      if (isFavorite) {
        String? pokemonJson = prefs.getString('pokemon_$i');
        if (pokemonJson != null) {
          Map<String, dynamic> pokemonMap = jsonDecode(pokemonJson);
          loadedFavorites.add(Pokemon.fromJson(pokemonMap));
        }
      }
    }

    setState(() {
      favoritePokemons = loadedFavorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: ListView.builder(
        itemCount: favoritePokemons.length,
        itemBuilder: (context, index) {
          Pokemon pokemon = favoritePokemons[index];
          return ListTile(
            leading: Image.network(pokemon.sprites.frontDefault,
                width: 50, height: 50, fit: BoxFit.cover),
            title: Text(pokemon.name),
            // Adicione aqui outros detalhes do Pokémon, como uma imagem
            onTap: () {
              // Ação ao tocar no Pokémon, se necessário
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(pokemon: pokemon),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
