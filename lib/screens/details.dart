import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Pokemon.dart';

class DetailPage extends StatefulWidget {
  final Pokemon pokemon;

  DetailPage({required this.pokemon});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  _checkFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFavorite = prefs.getBool('favorite_${widget.pokemon.id}') ?? false;
    setState(() {});
  }

  _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFavorite = !isFavorite;
    await prefs.setBool('favorite_${widget.pokemon.id}', isFavorite);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Alinha ao topo verticalmente
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centraliza horizontalmente
            children: [
              Center(
                  child: Image.network(widget
                      .pokemon.sprites.frontDefault)), // Centraliza a imagem
              const SizedBox(height: 8), // Espaçamento entre a imagem e o texto
              Center(
                  child: Text(
                      widget.pokemon.name.toUpperCase())), // Centraliza o texto
              Center(
                child: Text(
                  'Types: ${widget.pokemon.types.map((t) => t.type.name).join(', ')}',
                ),
              ),
              Center(
                  child: Text('Attack: ${widget.pokemon.stats[0].baseStat}')),
              Center(
                  child: Text('Defense: ${widget.pokemon.stats[1].baseStat}')),
              Center(child: Text('Speed: ${widget.pokemon.stats[5].baseStat}')),
              const SizedBox(height: 16), // Espaçamento antes do botão
              Center(
                child: ElevatedButton(
                  onPressed: _toggleFavorite,
                  child: Text(isFavorite
                      ? 'Remover dos favoritos'
                      : 'Adicionar aos favoritos'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
