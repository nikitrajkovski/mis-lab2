import 'package:flutter/material.dart';
import '../models/joke_model.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Joke> favorites;

  FavoritesScreen({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite Jokes")),
      body: favorites.isEmpty
          ? Center(child: Text("No favorite jokes yet!"))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favorites[index].setup),
            subtitle: Text(favorites[index].punchline),
          );
        },
      ),
    );
  }
}