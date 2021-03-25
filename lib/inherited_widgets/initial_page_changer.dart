import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

/// provides the currently selected theme, saves changed theme preferences to disk
class InitialPageController extends ChangeNotifier {
  InitialPageController(this._prefs) {
    // load theme from preferences on initialization
    _initPage = _prefs.getInt(initialPage) ?? 0;
  }

  final SharedPreferences _prefs;
  int _initPage;

  /// get the current theme
  int get initPage => _initPage;

  void setTheme(int initPageNum) {
    _initPage = initPageNum;

    // notify the app that the theme was changed
    notifyListeners();

    // store updated theme on disk
    _prefs.setInt(initialPage, initPageNum);
  }

  /// get the controller from any page of your app
  static InitialPageController of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<InitialPageControllerProvider>();
    return provider.controller;
  }
}

/// provides the theme controller to any page of your app
class InitialPageControllerProvider extends InheritedWidget {
  const InitialPageControllerProvider({Key key, this.controller, Widget child})
      : super(key: key, child: child);

  final InitialPageController controller;

  @override
  bool updateShouldNotify(InitialPageControllerProvider old) =>
      controller != old.controller;
}
