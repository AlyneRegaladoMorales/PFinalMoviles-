import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:super_comics_app/models/superhero.dart';

class Service{
  final String baseUrl = 'https://superheroapi.com/api/7019859888057850';

  Future<List<SuperHero>> searchHero(String name) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search/$name')
    );

    if (response.statusCode == HttpStatus.ok) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
          return results.map((hero) => SuperHero.fromMap(hero as Map<String, dynamic>)).toList();
    } else {
      return [];
    }
  }
}