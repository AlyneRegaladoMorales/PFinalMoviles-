import 'package:flutter/material.dart';
import 'package:super_comics_app/screeens/favorites_screen.dart';
import 'package:super_comics_app/screeens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SuperComicsApp'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/comics.jpg'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              child: Text('Consulta de SuperHéroe'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()),
                );
              },
              child: Text('Listado de SuperHéroes Favoritos'),
            ),
          ],
        ),
      ),
    );
  }
}