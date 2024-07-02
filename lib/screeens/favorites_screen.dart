import 'package:flutter/material.dart';
import 'package:super_comics_app/database/app_database.dart';
import 'package:super_comics_app/models/superhero.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<SuperHero>> _futureHeroes;

  @override
  void initState() {
    super.initState();
    _futureHeroes = AppDatabase().fetchAllSuperHeroes();
  }

  void _refreshHeroes() {
    setState(() {
      _futureHeroes = AppDatabase().fetchAllSuperHeroes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SuperHéroes Favoritos'),
      ),
      body: FutureBuilder<List<SuperHero>>(
        future: _futureHeroes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final heroes = snapshot.data ?? [];
            return ListView.builder(
              itemCount: heroes.length,
              itemBuilder: (context, index) {
                final hero = heroes[index];
                return ListTile(
                  title: Text(hero.name),
                  subtitle: Text('Inteligencia: ${hero.intelligence}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await _deleteHero(hero.id);
                      _refreshHeroes();
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  _deleteHero(String id) async {
    await AppDatabase().deleteSuperHero(id);
  }
}