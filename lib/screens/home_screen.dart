import 'package:flutter/material.dart';
import 'package:lab2mis/screens/random_joke_screen.dart';
import '../services/api_service.dart';
import '../models/joke_type_model.dart';
import 'joke_type_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<JokeType>> _jokeTypes;

  @override
  void initState() {
    super.initState();
    _jokeTypes = _apiService.getJokeTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("211060 is making people laugh"),
        actions: [
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RandomJokeScreen()),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<List<JokeType>>(
        future: _jokeTypes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          var jokeTypes = snapshot.data!;
          return ListView.builder(
            itemCount: jokeTypes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(jokeTypes[index].type),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => JokeTypeScreen(type: jokeTypes[index].type),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
