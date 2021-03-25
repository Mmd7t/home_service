import 'package:flutter/material.dart';
import 'package:home_service/inherited_widgets/initial_page_changer.dart';
import 'package:home_service/inherited_widgets/theme_changer.dart';
import 'package:home_service/pages/sign_in.dart';

import '../constants.dart';
import '../db/db.dart';
import '../models/user.dart';
import '../models/user.dart';

class Settings extends StatelessWidget {
  static const String routeName = 'settings';

  @override
  Widget build(BuildContext context) {
    var themeController = ThemeController.of(context);
    return Scaffold(
      appBar: new AppBar(
        title: Text('theme switcher'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: DB.db.getAllUserData(),
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
                heroTag: "light",
                label: Text('Light Theme'),
                onPressed: () {
                  themeController.setTheme('light');
                },
              ),
              SizedBox(height: 10),
              FloatingActionButton.extended(
                heroTag: "dark",
                label: Text('Dark Theme'),
                onPressed: () {
                  themeController.setTheme('dark');
                },
              ),
              SizedBox(height: 10),
              FloatingActionButton.extended(
                heroTag: "logout",
                label: Text('Logout'),
                onPressed: () async {
                  InitialPageController.of(context).setTheme(0);
                  DB.db.deleteData(User().id, userTable);
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
}
