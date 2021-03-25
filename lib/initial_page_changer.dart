import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class InitialPageController extends ChangeNotifier {
  InitialPageController(this._prefs) {
    _initPage = _prefs.getInt(initialPage) ?? 0;
  }

  SharedPreferences _prefs;
  int _initPage;

  int get initPage => _initPage;

  void setTheme(int initPageNum) {
    _initPage = initPageNum;
    notifyListeners();
    _prefs.setInt(initialPage, initPageNum);
  }

  static InitialPageController of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<InitialPageControllerProvider>();
    return provider.controller;
  }
}

class InitialPageControllerProvider extends InheritedWidget {
  const InitialPageControllerProvider({Key key, this.controller, Widget child})
      : super(key: key, child: child);

  final InitialPageController controller;

  @override
  bool updateShouldNotify(InitialPageControllerProvider old) =>
      controller != old.controller;
}
