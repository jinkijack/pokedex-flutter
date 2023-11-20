import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Pokemon.dart';
import './details.dart';
import 'dart:convert';
import '../services/PokemonService.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pokemon> pokemonList = [];
  List<Pokemon> filteredPokemonList = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_loadPokemonFromCache();
    addData();
  }

  bool showSearchBar = false;
  final FocusNode searchFocusNode = FocusNode();

  _loadPokemonFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 1; i <= 151; i++) {
      String? pokemonJson = prefs.getString('pokemon_$i');
      if (pokemonJson != null) {
        Map<String, dynamic> pokemonMap = jsonDecode(pokemonJson);
        Pokemon pokemon = Pokemon.fromJson(pokemonMap);
        pokemonList.add(pokemon);
      }
    }
    setState(() {});
  }

  _searchPokemons(String query) {
    filteredPokemonList.clear();
    for (Pokemon pokemon in pokemonList) {
      if (pokemon.name.toLowerCase().contains(query.toLowerCase()) ||
          pokemon.id.toString().contains(query.toLowerCase())) {
        filteredPokemonList.add(pokemon);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: showSearchBar
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    showSearchBar = false;
                  });
                },
              )
            : null, // Isso oculta o ícone do menu lateral quando a barra de pesquisa está aberta
        title: showSearchBar
            ? Container(
                width: 180,
                child: TextField(
                  focusNode: searchFocusNode,
                  showCursor: true,
                  cursorColor: Colors.white,
                  controller: searchController,
                  onChanged: _searchPokemons,
                  style: const TextStyle(
                      color: Colors.white), // Texto na cor branca
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white, // Cor da borda quando desfocado
                      ),
                    ), // Adiciona uma borda
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white, // Cor da borda quando desfocado
                      ),
                    ),
                  ),
                ),
              )
            : const Text('Pokedex'),
        actions: [
          if (!showSearchBar)
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  showSearchBar = true;
                  searchFocusNode.requestFocus();
                });
              },
            ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.red,
        width: 200,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.white),
              title: const Text('Favoritos'),
              onTap: () {
                // Navigate to Favorites Page
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: filteredPokemonList.isEmpty
            ? pokemonList.length
            : filteredPokemonList.length,
        itemBuilder: (context, index) {
          Pokemon pokemon = filteredPokemonList.isEmpty
              ? pokemonList[index]
              : filteredPokemonList[index];
          return ListTile(
            leading: Image.network(pokemon.sprites.frontDefault,
                width: 50, height: 50, fit: BoxFit.cover),
            title: Text(pokemon.name),
            onTap: () {
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

  void addData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 1; i <= 151; i++) {
      String? pokemonJson = prefs.getString('pokemon_$i');
      if (pokemonJson != null && pokemonJson.isNotEmpty) {
        Map<String, dynamic> pokemonMap = jsonDecode(pokemonJson);
        Pokemon pokemon = Pokemon.fromJson(pokemonMap);

        pokemonList.add(pokemon);
        // Se você estiver usando um StatefulWidget, você pode chamar setState() aqui
        setState(() {});

        print('[${pokemon.id}]-SPRITE CACHE: ${pokemon.sprites.frontDefault}');
        print('[${pokemon.id}]-POKEMON CACHE: Name: ${pokemon.name}');
        // ... Adicione os outros logs aqui ...
      } else {
        // Chamar a API para obter os dados do Pokémon
        Pokemon fetchedPokemon =
            await PokemonApiService.fetchPokemon(i.toString());
        _savePokemonToCache(fetchedPokemon);
        pokemonList.add(fetchedPokemon);
        // Se você estiver usando um StatefulWidget, você pode chamar setState() aqui
        setState(() {});

        print(
            '[${fetchedPokemon.id}]-SPRITE: ${fetchedPokemon.sprites.frontDefault}');
        print('[${fetchedPokemon.id}]-POKEMON: Name: ${fetchedPokemon.name}');
        // ... Adicione os outros logs aqui ...
      }
    }
  }

  void _savePokemonToCache(Pokemon pokemon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pokemonJson = jsonEncode(pokemon.toJson());
    await prefs.setString('pokemon_${pokemon.id}', pokemonJson);
  }
}
