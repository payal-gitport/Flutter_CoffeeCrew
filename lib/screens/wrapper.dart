import 'package:CoffeeCrew/models/user.dart';
import 'package:CoffeeCrew/screens/authenticate/authenticate.dart';
import 'package:CoffeeCrew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
