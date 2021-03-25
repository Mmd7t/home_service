import 'package:flutter/material.dart';
import 'package:home_service/database.dart';
import 'package:home_service/models/worker.dart';

class UserSelectedWorkerPage extends StatelessWidget {
  final String tableName;
  final int index;

  const UserSelectedWorkerPage({Key key, this.tableName, this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Home")),
      body: Center(
        child: FutureBuilder(
          future: MyDatabase.db.getAllWorkerData(tableName),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              Worker worker = snapshot.data[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Selected Worker Data",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(worker.name),
                  Text(worker.phoneNum),
                  Text(worker.dateTime),
                  Text((worker.isBusy == 1) ? "He is Busy" : "He is not Busy"),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
