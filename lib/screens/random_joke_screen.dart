import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/joke_model.dart';

class RandomJokeScreen extends StatefulWidget {
  @override
  _RandomJokeScreenState createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  final ApiService _apiService = ApiService();
  late Future<Joke> _randomJoke;

  @override
  void initState() {
    super.initState();
    _randomJoke = _apiService.getRandomJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Random Joke for your taste")),
      body: FutureBuilder<Joke>(
        future: _randomJoke,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          var joke = snapshot.data!;
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(joke.setup, style: TextStyle(fontSize: 24)),
                SizedBox(height: 20),
                Text(joke.punchline, style: TextStyle(fontSize: 24)),
              ],
            ),
          );
        },
      ),
    );
  }
}
