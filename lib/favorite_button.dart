import 'package:flutter/material.dart';
import 'package:star_app/favorite_articles.dart';
import 'articles.dart';
import 'user.dart';

class FavoriteButton extends StatefulWidget {
  final User user;
  final VoidCallback onToggleFavorite;
  final int id;

  FavoriteButton({
    required this.user,
    required this.onToggleFavorite,
    required this.id,
  });

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite_border),
      selectedIcon: Icon(Icons.favorite),
      color: articles[widget.id].colorFavoriteButton,
      onPressed: () {
        if (articles[widget.id].isFavorite == false) {
          favoriteArticles.add(Article(
            id: favoriteArticles.length,
            title: articles[widget.id].title,
            content: articles[widget.id].content,
            zodiacSign: articles[widget.id].zodiacSign,
            date: articles[widget.id].date,
            imageUrl: articles[widget.id].imageUrl,
            isFavorite: articles[widget.id].isFavorite,
            colorFavoriteButton: articles[widget.id].colorFavoriteButton,
          ));
          articles[widget.id].colorFavoriteButton = Color.fromARGB(255, 55, 0, 253);
          setState(() {
            articles[widget.id].isFavorite =
                !articles[widget.id].isFavorite;
            widget.onToggleFavorite();
          });
        } else {
          favoriteArticles
              .removeWhere((element) => element.content == articles[widget.id].content);
          articles[widget.id].colorFavoriteButton = Colors.grey;
          setState(() {
            articles[widget.id].isFavorite =
                !articles[widget.id].isFavorite;
            widget.onToggleFavorite();
            var counter = 0;
            while (counter < favoriteArticles.length) {
              favoriteArticles[counter].id = counter;
              counter++;
            }
          });
        }
      },
    );
  }
}
