import 'package:home_service/pages/home.dart';
import 'package:home_service/pages/settings/settings.dart';
import 'package:home_service/pages/worker_pages/workers_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'inherited_widgets/theme_changer.dart';
import 'pages/splash_screen.dart';
import 'pages/user_pages/user_home_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // load the shared preferences from disk before the app is started
  final prefs = await SharedPreferences.getInstance();

  // create new theme controller, which will get the currently selected from shared preferences
  final themeController = ThemeController(prefs);

  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  final ThemeController themeController;

  const MyApp({Key key, this.themeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, child) {
        return ThemeControllerProvider(
          controller: themeController,
          child: MaterialApp(
            title: 'Home Service',
            debugShowCheckedModeBanner: false,
            theme: _buildCurrentTheme(),
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => SplashScreen(),
              Home.routeName: (context) => Home(),
              Settings.routeName: (context) => Settings(),
              WorkersHomePage.routeName: (context) => WorkersHomePage(),
              UserHomePage.routeName: (context) => UserHomePage(),
            },
          ),
        );
      },
    );
  }

  // build the flutter theme from the saved theme string
  ThemeData _buildCurrentTheme() {
    switch (themeController.currentTheme) {
      case "dark":
        return ThemeData.dark().copyWith(
          primaryColor: Colors.redAccent,
        );
      case "light":
      default:
        return ThemeData.light().copyWith(
          primaryColor: Colors.redAccent,
        );
    }
  }
}
