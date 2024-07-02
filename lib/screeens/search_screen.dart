import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_comics_app/database/app_database.dart';
import 'package:super_comics_app/models/superhero.dart';
import 'package:super_comics_app/service/service.dart';



class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List _heroes = [];
  int _resultFavoriteCount = 0;
  final Service _service = Service();

   @override
  void initState() {
    super.initState();
    _favorite(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar SuperHéroe'),
      ),
      body: Padding(
      
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nombre del SuperHéroe',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchHero,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Marcado como favoritos: $_resultFavoriteCount'),
            Expanded(
              child: ListView.builder(
                itemCount: _heroes.length,
                itemBuilder: (context, index) {
                  final hero = _heroes[index];
                  return ListTile(
                    title: Text(hero.name),
                    subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Inteligencia: ${hero.intelligence}'),
                      Text('Género: ${hero.gender}'),
                    ],
                  ),
                    leading: Image.network(hero.image),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () => _saveFavorite(hero),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _searchHero() async {
    final name = _controller.text;
    List heroes = await _service.searchHero(name);
    setState(() {
      _heroes = heroes;
    });
  }
  _saveFavorite(SuperHero hero) async {
    
    try {
    await AppDatabase().insertSuperHero(hero);
    List<SuperHero> favorites = await AppDatabase().fetchAllSuperHeroes();
    setState(() {
      _resultFavoriteCount = favorites.length;
    });
    } catch (e) {
      print('Error al guardar el favorito: $e');
    }
  }
  _favorite() async {
    List<SuperHero> favorites = await AppDatabase().fetchAllSuperHeroes();
    setState(() {
      _resultFavoriteCount = favorites.length;
    });
  }
}