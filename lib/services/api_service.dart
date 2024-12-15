import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke_model.dart';
import '../models/joke_type_model.dart';

class ApiService {
  final String baseUrl = "https://official-joke-api.appspot.com";

  Future<List<JokeType>> getJokeTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/types'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((type) => JokeType.fromJson({'type': type})).toList();
    } else {
      throw Exception('Failed to load joke types');
    }
  }

  Future<List<Joke>> getJokesByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/jokes/$type/ten'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((joke) => Joke.fromJson(joke)).toList();
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  Future<Joke> getRandomJoke() async {
    final response = await http.get(Uri.parse('$baseUrl/random_joke'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return Joke.fromJson(data);
    } else {
      throw Exception('Failed to load random joke');
    }
  }
}