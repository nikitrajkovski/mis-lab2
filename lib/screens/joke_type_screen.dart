import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/joke_model.dart';

class JokeTypeScreen extends StatefulWidget {
  final String type;
  final List<Joke> favorites;
  final Function(Joke joke, bool isAdding) onFavoriteToggle;

  JokeTypeScreen({
    required this.type,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  @override
  _JokeTypeScreenState createState() => _JokeTypeScreenState();
}

class _JokeTypeScreenState extends State<JokeTypeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Joke>> _jokes;

  @override
  void initState() {
    super.initState();
    _jokes = _apiService.getJokesByType(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.type)),
      body: FutureBuilder<List<Joke>>(
        future: _jokes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          var jokes = snapshot.data!;
          return ListView.builder(
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              final joke = jokes[index];
              final isFavorite = widget.favorites.contains(joke);

              return ListTile(
                title: Text(joke.setup),
                subtitle: Text(joke.punchline),
                trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isFavorite) {
                        widget.onFavoriteToggle(joke, false);
                      } else {
                        widget.onFavoriteToggle(joke, true);
                      }
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
