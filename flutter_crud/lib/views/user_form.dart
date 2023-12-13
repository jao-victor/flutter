//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  // aqui parece que ele mudou de um vídeo para o outro
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  bool _isLoading = false;

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  /*@override
  void didChangeDependencies() {
    //super.di();
    final User user = ModalRoute.of(context).settings.arguments;
    _loadFormData(user);
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formuláirio do Usuário'),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                final isValid = _form.currentState!.validate();

                if (isValid) {
                  _form.currentState!.save();

                  setState(() {
                    _isLoading = true;
                  });

                  await Provider.of<Users>(context, listen: false).put(
                    User(
                        id: _formData['id']!,
                        name: _formData['name']!,
                        email: _formData['email']!,
                        avatarUrl: _formData['avatarUrl']!),
                  );

                  setState(() {
                    _isLoading = false;
                  });

                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _formData['name'],
                      decoration: InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nome inválido';
                        }

                        return null;
                      },
                      onSaved: (value) => _formData['name'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['email'],
                      decoration: InputDecoration(labelText: 'Email'),
                      onSaved: (value) => _formData['email'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['avatarUrl'],
                      decoration: InputDecoration(labelText: 'URL do Avatar'),
                      onSaved: (value) => _formData['avatarUrl'] = value!,
                    ),
                  ],
                ),
              )),
    );
  }
}
