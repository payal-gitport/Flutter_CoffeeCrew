import 'package:CoffeeCrew/screens/wrapper.dart';
import 'package:CoffeeCrew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CoffeeCrew/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),

        // theme: ThemeData(primaryColor: Colors.brown[900]),
        // title: 'Word Generator',
        // home: RandomWords(),
      ),
    );
  }
}
