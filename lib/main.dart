import 'package:home_service/inherited_widgets/initial_page_changer.dart';
import 'package:home_service/pages/home.dart';
import 'package:home_service/pages/settings.dart';
import 'package:home_service/pages/sign_in.dart';
import 'package:home_service/pages/worker_pages/workers_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'inherited_widgets/theme_changer.dart';
import 'pages/user_pages/user_home_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // load the shared preferences from disk before the app is started
  final prefs = await SharedPreferences.getInstance();

  final initPageController = InitialPageController(prefs);
  // prefs.setInt(initialPage, 1);

  // create new theme controller, which will get the currently selected from shared preferences
  final themeController = ThemeController(prefs);

  runApp(MyApp(
    themeController: themeController,
    initPageController: initPageController,
  ));
}

class MyApp extends StatelessWidget {
  final ThemeController themeController;
  final InitialPageController initPageController;

  const MyApp({Key key, this.themeController, this.initPageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, child) {
        return InitialPageControllerProvider(
          controller: initPageController,
          child: ThemeControllerProvider(
            controller: themeController,
            child: MaterialApp(
              title: 'Home Service',
              debugShowCheckedModeBanner: false,
              theme: _buildCurrentTheme(),
              initialRoute: (initPageController.initPage == 0 ||
                      initPageController.initPage == null)
                  ? SignInPage.routeName
                  : Home.routeName,
              routes: {
                Home.routeName: (context) => Home(),
                Settings.routeName: (context) => Settings(),
                WorkersHomePage.routeName: (context) => WorkersHomePage(),
                UserHomePage.routeName: (context) => UserHomePage(),
                SignInPage.routeName: (context) => SignInPage(),
              },
            ),
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
