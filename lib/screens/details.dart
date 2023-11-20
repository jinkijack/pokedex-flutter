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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(widget.pokemon.sprites.frontDefault),
            Text(widget.pokemon.name),
            Text(
                'Types: ${widget.pokemon.types.map((t) => t.type.name).join(', ')}'),
            Text('Attack: ${widget.pokemon.stats[0].baseStat}'),
            Text('Defense: ${widget.pokemon.stats[1].baseStat}'),
            Text('Speed: ${widget.pokemon.stats[5].baseStat}'),
            ElevatedButton(
              onPressed: _toggleFavorite,
              child: Text(
                  isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}
