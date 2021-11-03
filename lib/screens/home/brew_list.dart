import 'package:brew_crew2/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context);
    // if (brews != null) {
    //   print(brews!.docs);
    // }

    if (brews != null) {
      brews.forEach((brew) {
        print(brew.name);
        print(brew.sugars);
        print(brew.strength);
      });
      // for (var doc in brews.docs) {
      //   print(doc.data());
      // }
    }
    return Container();
  }
}
