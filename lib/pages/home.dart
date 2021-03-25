import 'package:flutter/material.dart';
import 'package:home_service/components/common_container.dart';
import 'package:home_service/pages/user_pages/user_home_page.dart';
import 'package:home_service/pages/worker_pages/workers_home.dart';

import 'settings.dart';

class Home extends StatelessWidget {
  static const String routeName = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Services"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed(Settings.routeName);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonContainer(
              title: "Worker",
              onTap: () {
                Navigator.of(context).pushNamed(WorkersHomePage.routeName);
              },
            ),
            const SizedBox(height: 10),
            CommonContainer(
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
