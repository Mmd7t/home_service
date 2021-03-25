import 'package:flutter/material.dart';
import 'package:home_service/initial_page_changer.dart';
import 'package:home_service/pages/sign_in.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';
import '../database.dart';
import '../models/user.dart';

class Settings extends StatefulWidget {
  static const String routeName = 'settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  MyDatabase database = MyDatabase.db;
  int count = 0;
  List<User> userData;
  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      userData = [];
      updateContent();
    }
    return Scaffold(
      appBar: new AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: MyDatabase.db.getAllUserData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    User user = snapshot.data[0];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          user.name,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: 10),
                        Text(user.email,
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: 35),
              FloatingActionButton.extended(
                heroTag: "logout",
                label: Text('Logout'),
                onPressed: () async {
                  InitialPageController.of(context).setTheme(0);
                  await MyDatabase.db
                      .deleteData(this.userData[0].id, userTable);
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(SignInPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateContent() {
    final Future<Database> futureDb = database.initDB();
    futureDb.then((value) {
      Future<List<User>> userDataFuture = database.getAllUserData();
      userDataFuture.then((value) {
        setState(() {
          this.userData = value;
          this.count = value.length;
        });
      });
    });
  }
}
