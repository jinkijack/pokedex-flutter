import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonApiService {
  static const String API_URL = "https://pokeapi.co/api/v2/pokemon/";

  static Future<Pokemon> fetchPokemon(String pokemonIdOrName) async {
    final response = await http.get(Uri.parse(API_URL + pokemonIdOrName));
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return Pokemon.fromJson(jsonResponse);
  }
}
