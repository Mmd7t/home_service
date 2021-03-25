import 'package:flutter/material.dart';
import 'package:home_service/inherited_widgets/theme_changer.dart';

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
              FloatingActionButton.extended(
                label: Text('Light Theme'),
                onPressed: () {
                  themeController.setTheme('light');
                },
              ),
              SizedBox(height: 10),
              FloatingActionButton.extended(
                label: Text(
                  'Dark Theme',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  themeController.setTheme('dark');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
