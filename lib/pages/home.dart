import 'package:flutter/material.dart';
import 'package:home_service/pages/user_pages/user_home_page.dart';
import 'package:home_service/pages/worker_pages/workers_home.dart';
import 'package:home_service/widgets/global_box.dart';
import 'package:home_service/widgets/common_appbar.dart';

class Home extends StatelessWidget {
  static const String routeName = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(isHome: true, title: 'Home Services'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalBox(
              title: "Worker",
              onTap: () {
                Navigator.of(context).pushNamed(WorkersHomePage.routeName);
              },
            ),
            const SizedBox(height: 10),
            GlobalBox(
              title: "User",
              onTap: () {
                Navigator.of(context).pushNamed(UserHomePage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
