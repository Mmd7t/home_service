import 'package:flutter/material.dart';
import 'package:home_service/common_container.dart';
import 'package:home_service/pages/user_pages/show_workers_data.dart';

import '../../constants.dart';

class UserHomePage extends StatelessWidget {
  static const String routeName = "userHomePage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonContainer(
              title: "Kahraba2y",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ShowWorkersDataToUser(tableName: kahrba2yTable),
                ));
              },
            ),
            const SizedBox(height: 10),
            CommonContainer(
              title: "Sabbak",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ShowWorkersDataToUser(tableName: sabbakTable),
                ));
              },
            ),
            const SizedBox(height: 10),
            CommonContainer(
              title: "Naggar",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ShowWorkersDataToUser(tableName: naggarTable),
                ));
              },
            ),
            const SizedBox(height: 10),
            CommonContainer(
              title: "Delivery",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ShowWorkersDataToUser(tableName: deliveryTable),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
