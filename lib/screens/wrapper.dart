import 'package:brew_crew2/models/my_user.dart';
import 'package:brew_crew2/screens/authenticate/authenticate.dart';
import 'package:brew_crew2/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    // return either Home or Authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
