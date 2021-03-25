import 'package:flutter/material.dart';
import 'package:home_service/components/common_container.dart';
import 'package:home_service/constants.dart';
import 'package:home_service/pages/settings.dart';
import 'package:home_service/pages/worker_pages/show_workers_list.dart';

class WorkersHomePage extends StatelessWidget {
  static const String routeName = 'workersHomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workers Home"),
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
              title: "Kahraba2y",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ShowWorkersList(tableName: kahrba2yTable),
                ));
              },
            ),
            const SizedBox(height: 10),
            CommonContainer(
              title: "Sabbak",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowWorkersList(tableName: sabbakTable),
                ));
              },
            ),
            const SizedBox(height: 10),
            CommonContainer(
              title: "Naggar",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowWorkersList(tableName: naggarTable),
                ));
              },
            ),
            const SizedBox(height: 10),
            CommonContainer(
              title: "Delivery",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ShowWorkersList(tableName: deliveryTable),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
