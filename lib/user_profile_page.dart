import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'favorite_articles.dart';
import 'user.dart';
import 'article_detail_page.dart';

class UserProfilePage extends StatefulWidget {
  final User user;

  UserProfilePage({required this.user});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _formattedDate = '';
  bool _isEditing = false;
  final _nameController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ru', null).then((_) {
      setState(() {
        _formattedDate = DateFormat('dd MMMM yyyy', 'ru').format(DateTime.parse(widget.user.dateOfBirth));
        _nameController.text = widget.user.name;
        _loginController.text = widget.user.login;
        _passwordController.text = widget.user.password;
        _dateOfBirthController.text = widget.user.dateOfBirth;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        widget.user.updateName(_nameController.text);
        widget.user.updateLogin(_loginController.text);
        widget.user.updatePassword(_passwordController.text);
        widget.user.updateDateOfBirth(_dateOfBirthController.text);
        _formattedDate = DateFormat('dd MMMM yyyy', 'ru').format(DateTime.parse(_dateOfBirthController.text));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(' ${widget.user.login}'),
        backgroundColor: Color.fromARGB(255, 77, 70, 170),
      ),
      body: Container(
        color: Color.fromARGB(255, 158, 160, 223),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/zodiac_s.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16.0,
                    right: 16.0,
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed: _toggleEditing,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _isEditing
                        ? TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Имя'),
                    )
                        : Text(
                      'Имя: ${widget.user.name}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 8.0),
                    _isEditing
                        ? TextField(
                      controller: _loginController,
                      decoration: InputDecoration(labelText: 'Логин'),
                    )
                        : Text(
                      'Логин: ${widget.user.login}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 8.0),
                    _isEditing
                        ? TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Пароль'),
                      obscureText: true,
                    )
                        : Text(
                      'Пароль: ${widget.user.password}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 8.0),
                    _isEditing
                        ? TextField(
                      controller: _dateOfBirthController,
                      decoration: InputDecoration(labelText: 'Дата рождения'),
                    )
                        : Text(
                      'Дата рождения: $_formattedDate',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Знак зодиака: ${widget.user.getZodiacSign()}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Избранные статьи:',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: favoriteArticles.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            leading: Image.network(
                              favoriteArticles[index].imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(favoriteArticles[index].title),
                            subtitle: Text(favoriteArticles[index].content),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticleDetailPage(
                                    title: favoriteArticles[index].title,
                                    content: favoriteArticles[index].content,
                                    zodiacSign: favoriteArticles[index].zodiacSign,
                                    date: favoriteArticles[index].date.toString(),
                                    imageUrl: favoriteArticles[index].imageUrl,
                                    isFavorite: true,
                                    onToggleFavorite: () {},
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
