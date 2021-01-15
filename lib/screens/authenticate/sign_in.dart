import 'package:CoffeeCrew/services/auth.dart';
import 'package:CoffeeCrew/shared/constants.dart';
import 'package:CoffeeCrew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text Field State
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in to CoffeeCrew'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Register'))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        validator: (value) {
                          if (value.isEmpty) return 'Enter a email';
                          Pattern pattern =
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(value))
                            return 'Invalid email';
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        validator: (value) {
                          if (value.isEmpty) return 'Enter a password';
                          Pattern pattern =
                              r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
                          //Minimum eight characters, at least one letter and one number:
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(value))
                            return 'Invalid password';
                          else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        color: Colors.brown[400],
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Invalid email/password';
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                )),
          );
  }
}
