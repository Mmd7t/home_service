import 'package:flutter/material.dart';
import 'package:home_service/initial_page_changer.dart';

import '../constants.dart';
import '../database.dart';
import '../models/user.dart';
import 'home.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = 'signInPage';
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String name, email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                "Home Services",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          Container(
            child: Form(
              key: formState,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
// name text field
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 18),
                        filled: true,
                        fillColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please fill the label";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {
                        setState(() {
                          name = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
// email text field
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 18),
                        filled: true,
                        fillColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please fill the label";
                        } else if (!value.contains('@')) {
                          return 'Please enter valid email';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {
                        setState(() {
                          email = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
// password text field
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 18),
                        filled: true,
                        fillColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please fill the label";
                        } else if (value.length < 6) {
                          return 'Please enter at least 6 digits';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {
                        setState(() {
                          password = newValue;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 16),
                        child: Text(
                          'Sign up',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          if (formState.currentState.validate()) {
                            formState.currentState.save();
                            await MyDatabase.db.insertData(
                                User(
                                    name: name,
                                    email: email,
                                    password: password),
                                userTable);
                            InitialPageController.of(context).setTheme(1);
                            Navigator.of(context)
                                .pushReplacementNamed(Home.routeName);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
