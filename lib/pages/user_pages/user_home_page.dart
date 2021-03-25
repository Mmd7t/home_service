import 'package:flutter/material.dart';
import 'package:home_service/pages/user_pages/show_workers_data.dart';
import 'package:home_service/widgets/common_appbar.dart';
import 'package:home_service/widgets/global_box.dart';

import '../../constants.dart';

class UserHomePage extends StatelessWidget {
  static const String routeName = "userHomePage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(title: "User Home"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalBox(
              title: "Kahraba2y",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ShowWorkersDataToUser(tableName: kahrba2yTable),
                ));
              },
            ),
            const SizedBox(height: 10),
            GlobalBox(
              title: "Sabbak",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ShowWorkersDataToUser(tableName: sabbakTable),
                ));
              },
            ),
            const SizedBox(height: 10),
            GlobalBox(
              title: "Naggar",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ShowWorkersDataToUser(tableName: naggarTable),
                ));
              },
            ),
            const SizedBox(height: 10),
            GlobalBox(
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
