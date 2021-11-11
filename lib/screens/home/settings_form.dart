import 'package:brew_crew2/models/my_user.dart';
import 'package:brew_crew2/services/database.dart';
import 'package:brew_crew2/shared/constants.dart';
import 'package:brew_crew2/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  late String _currentName;
  late String _currentSugars;
  late int _currentStrength;

  // initializing variables
  @override
  void initState() {
    _currentName = '';
    _currentSugars = '';
    _currentStrength = 100;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(height: 20.0),
                  // dropdown
                  DropdownButtonFormField(
                    value:
                        _currentSugars == '' ? userData.sugars : _currentSugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    // If we don't use onChanged, dropdown menu will not be clickable
                    onChanged: (val) {
                      setState(() {
                        _currentSugars = val.toString();
                      });
                    },
                  ),
                  // slider
                  Slider(
                    value: (_currentStrength == 100
                            ? userData.strength
                            : _currentStrength)
                        .toDouble(),
                    activeColor: Colors.brown[_currentStrength == 100
                        ? userData.strength
                        : _currentStrength],
                    inactiveColor: Colors.brown[_currentStrength == 100
                        ? userData.strength
                        : _currentStrength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  ElevatedButton(
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.brown),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars == ''
                                  ? userData.sugars
                                  : _currentSugars,
                              _currentName == '' ? userData.name : _currentName,
                              _currentStrength == 100
                                  ? userData.strength
                                  : _currentStrength);
                          Navigator.pop(context);
                          print(_currentName);
                          print(_currentSugars);
                          print(_currentStrength);
                        }
                      }),
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
