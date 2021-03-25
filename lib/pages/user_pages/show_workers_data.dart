import 'package:flutter/material.dart';
import 'package:home_service/models/worker.dart';
import 'package:home_service/database.dart';
import 'package:home_service/pages/user_pages/user_selected_worker_page.dart';
import 'package:sqflite/sqflite.dart';

class ShowWorkersDataToUser extends StatefulWidget {
  final String tableName;

  const ShowWorkersDataToUser({Key key, @required this.tableName})
      : super(key: key);
  @override
  _ShowWorkersDataToUserState createState() => _ShowWorkersDataToUserState();
}

class _ShowWorkersDataToUserState extends State<ShowWorkersDataToUser> {
  MyDatabase database = MyDatabase.db;
  int count = 0;
  List<Worker> workersList;

  @override
  Widget build(BuildContext context) {
    if (workersList == null) {
      workersList = [];
      updateContent();
    }
    return Scaffold(
      appBar: AppBar(title: Text("Workers List")),
      body: FutureBuilder(
          future: database.getAllWorkerData(widget.tableName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Worker worker = snapshot.data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserSelectedWorkerPage(
                                tableName: widget.tableName,
                                index: index,
                              )));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                      child: ListTile(
                        title: Text("Name : ${worker.name}"),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: const CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  updateContent() {
    final Future<Database> futureDb = database.initDB();
    futureDb.then((value) {
      Future<List<Worker>> workersListFuture =
          database.getAllWorkerData(widget.tableName);
      workersListFuture.then((value) {
        setState(() {
          this.workersList = value;
          this.count = value.length;
        });
      });
    });
  }
}
