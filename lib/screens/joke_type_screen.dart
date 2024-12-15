import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/joke_model.dart';

class JokeTypeScreen extends StatefulWidget {
  final String type;
  JokeTypeScreen({required this.type});

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
              return ListTile(
                title: Text(jokes[index].setup),
                subtitle: Text(jokes[index].punchline),
              );
            },
          );
        },
      ),
    );
  }
}
