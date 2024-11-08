import 'package:flutter/material.dart';
import 'article_detail_page.dart';
import 'articles.dart';
import 'user.dart';
import 'favorite_button.dart';

class AstrologyHomePage extends StatefulWidget {
  final User user;

  AstrologyHomePage({required this.user});

  @override
  _AstrologyHomePageState createState() => _AstrologyHomePageState();
}

class _AstrologyHomePageState extends State<AstrologyHomePage> {

  String? selectedZodiacSign;
  String selectedDateFilter = 'All';
  List<String> zodiacSigns = ['Овен', 'Телец', 'Близнецы', 'Рак', 'Лев', 'Дева', 'Весы', 'Скорпион', 'Стрелец', 'Козерог', 'Водолей', 'Рыбы'];
  List<String> dateFilters = ['All', 'Day', 'Week', 'Month'];

  DateTime get currentDate => DateTime.now();

  DateTime get startOfWeek => currentDate.subtract(Duration(days: currentDate.weekday - 1));
  DateTime get endOfWeek => startOfWeek.add(Duration(days: 6));

  @override
  void initState() {
    super.initState();
    selectedZodiacSign = widget.user.getZodiacSign();
  }

  List<Article> get filteredArticles {
    return articles.where((article) {
      bool zodiacMatch = selectedZodiacSign == null || article.zodiacSign == selectedZodiacSign;
      bool dateMatch = true;

      DateTime articleDate = article.date;

      if (selectedDateFilter == 'Day') {
        dateMatch = articleDate.year == currentDate.year &&
            articleDate.month == currentDate.month &&
            articleDate.day == currentDate.day;
      } else if (selectedDateFilter == 'Week') {
        dateMatch = articleDate.isAfter(startOfWeek.subtract(Duration(days: 1))) && articleDate.isBefore(endOfWeek.add(Duration(days: 2)));
      } else if (selectedDateFilter == 'Month') {
        dateMatch = articleDate.year == currentDate.year && articleDate.month == currentDate.month;
      }

      return zodiacMatch && dateMatch;
    }).toList();
  }

  void _toggleFavorite(String title) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Новости'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Выберите знак зодиака'),
                    value: selectedZodiacSign,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedZodiacSign = newValue;
                      });
                    },
                    items: zodiacSigns.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Выберите фильтр даты'),
                    value: selectedDateFilter,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDateFilter = newValue!;
                      });
                    },
                    items: dateFilters.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredArticles.length,
              itemBuilder: (context, index) {
                final article = filteredArticles[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(article.title),
                    subtitle: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Дата: ${article.date.toString().split(' ')[0]}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Знак зодиака: ${article.zodiacSign}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Image.network(
                            article.imageUrl,
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            article.content,
                            style: TextStyle(fontSize: 14.0),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.0),
                          FavoriteButton(
                            user: widget.user,
                            onToggleFavorite: () => _toggleFavorite(article.title), id: filteredArticles[index].id,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetailPage(
                            title: article.title,
                            content: article.content,
                            zodiacSign: article.zodiacSign,
                            date: article.date.toString().split(' ')[0],
                            imageUrl: article.imageUrl,
                            isFavorite: article.isFavorite,
                            onToggleFavorite: () => _toggleFavorite(article.title),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
