import 'package:home_service/initial_page_changer.dart';
import 'package:home_service/pages/home.dart';
import 'package:home_service/pages/settings.dart';
import 'package:home_service/pages/sign_in.dart';
import 'package:home_service/pages/worker_pages/workers_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/user_pages/user_home_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final initPageController = InitialPageController(prefs);
  runApp(MyApp(initPageController: initPageController));
}

class MyApp extends StatelessWidget {
  final InitialPageController initPageController;

  const MyApp({Key key, this.initPageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InitialPageControllerProvider(
      controller: initPageController,
      child: MaterialApp(
        title: 'Home Service',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.redAccent,
        ),
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
    );
  }
}
