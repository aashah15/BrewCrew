import 'package:brew_crew2/shared/constants.dart';
import 'package:flutter/material.dart';

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
            decoration: textInputDecoration,
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          const SizedBox(height: 20.0),
          // dropdown
          DropdownButtonFormField(
            value: _currentSugars == '' ? sugars[0] : sugars[0],
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
          ElevatedButton(
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.brown),
              onPressed: () async {
                print(_currentName);
                print(_currentSugars);
                print(_currentStrength);
              }),
        ],
      ),
    );
  }
}
