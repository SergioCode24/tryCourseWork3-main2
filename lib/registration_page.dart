import 'package:flutter/material.dart';
import 'user.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  void _register() {
    if (_formKey.currentState!.validate()) {
      User newUser = User(
        name: _nameController.text,
        login: _loginController.text,
        password: _passwordController.text,
        dateOfBirth: _dateOfBirthController.text,
        favoriteArticles: [],
      );
      User.users.add(newUser);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Регистрация",
          style: TextStyle(color: Color.fromARGB(255, 211, 211, 211)),
        ),
        backgroundColor: const Color.fromARGB(255, 77, 70, 170),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/zodiac_s.png'), // Используйте AssetImage для локального изображения
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(16.0, 64.0, 16.0, 32.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 158, 160, 223),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Регистрация',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 211, 211, 211),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Имя',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, введите имя';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          controller: _loginController,
                          decoration: InputDecoration(
                            labelText: 'Логин',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, введите логин';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Пароль',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, введите пароль';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _dateOfBirthController,
                                decoration: InputDecoration(
                                  labelText: 'Дата рождения (YYYY-MM-DD)',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Пожалуйста, введите дату рождения';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Tooltip(
                              message: 'Введите дату рождения в формате год-месяц-день, цифрами, пример 1990-06-01',
                              child: IconButton(
                                icon: Icon(Icons.help),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 77, 70, 170),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Зарегистрироваться',
                          style: TextStyle(color: Color.fromARGB(255, 221, 221, 221)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
