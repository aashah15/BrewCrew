import 'package:brew_crew2/screens/home/brew_list.dart';
import 'package:brew_crew2/services/auth.dart';
import 'package:brew_crew2/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
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
            )
          ],
        ),
        body: const BrewList(),
      ),
    );
  }
}
