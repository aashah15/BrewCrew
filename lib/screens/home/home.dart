import 'package:brew_crew2/models/brew.dart';
import 'package:brew_crew2/screens/home/brew_list.dart';
import 'package:brew_crew2/services/auth.dart';
import 'package:brew_crew2/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: const Text('bottom sheet'),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: const <Brew>[],
      catchError: (_, __) => const <Brew>[],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('Logout'),
              style: TextButton.styleFrom(primary: Colors.black),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text('Settings'),
              style: TextButton.styleFrom(primary: Colors.black),
              onPressed: () {
                _showSettingsPanel();
              },
            )
          ],
        ),
        body: const BrewList(),
      ),
    );
  }
}
