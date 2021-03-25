import 'package:flutter/material.dart';
import 'package:home_service/constants.dart';
import 'package:home_service/pages/worker_pages/show_workers_list.dart';
import 'package:home_service/widgets/global_box.dart';
import 'package:home_service/widgets/common_appbar.dart';

class WorkersHomePage extends StatelessWidget {
  static const String routeName = 'workersHomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(isHome: true, title: 'Workers Home'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalBox(
              title: "Kahraba2y",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ShowWorkersList(tableName: kahrba2yTable),
                ));
              },
            ),
            const SizedBox(height: 10),
            GlobalBox(
              title: "Sabbak",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowWorkersList(tableName: sabbakTable),
                ));
              },
            ),
            const SizedBox(height: 10),
            GlobalBox(
              title: "Naggar",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowWorkersList(tableName: naggarTable),
                ));
              },
            ),
            const SizedBox(height: 10),
            GlobalBox(
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
