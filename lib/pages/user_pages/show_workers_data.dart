import 'package:flutter/material.dart';
import 'package:home_service/models/worker.dart';
import 'package:home_service/db/db.dart';
import 'package:home_service/pages/settings.dart';
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
  DB database = DB.db;
  int count = 0;
  List<Worker> rentCarsList;

  @override
  Widget build(BuildContext context) {
    if (rentCarsList == null) {
      rentCarsList = [];
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Workers List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed(Settings.routeName);
            },
          )
        ],
      ),
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

  updateListView() {
    final Future<Database> futureDb = database.initDB();
    futureDb.then((value) {
      Future<List<Worker>> noteListFuture =
          database.getAllWorkerData(widget.tableName);
      noteListFuture.then((value) {
        setState(() {
          this.rentCarsList = value;
          this.count = value.length;
        });
      });
    });
  }
}
