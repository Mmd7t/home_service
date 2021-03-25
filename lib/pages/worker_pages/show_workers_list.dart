import 'package:flutter/material.dart';
import 'package:home_service/models/worker.dart';
import 'package:home_service/db/db.dart';
import 'package:home_service/pages/settings.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/worker.dart';
import 'add_worker_data.dart';
import 'edit_worker_data.dart';

class ShowWorkersList extends StatefulWidget {
  final String tableName;

  const ShowWorkersList({Key key, @required this.tableName}) : super(key: key);
  @override
  _ShowWorkersListState createState() => _ShowWorkersListState();
}

class _ShowWorkersListState extends State<ShowWorkersList> {
  DB database = DB.db;
  int count = 0;
  List<Worker> workersList;

  @override
  Widget build(BuildContext context) {
    if (workersList == null) {
      workersList = [];
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
                  bool workerIsBusy = (worker.isBusy == 1) ? true : false;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name :  ${worker.name}'),
                        const SizedBox(height: 5),
                        Text('Price in Day :  ${worker.phoneNum}'),
                        const SizedBox(height: 5),
                        Text('Date Time :  ${worker.dateTime}'),
                        const SizedBox(height: 5),
                        Text((workerIsBusy) ? "He is Busy" : "He is Not Busy"),
                        Switch(
                          value: workerIsBusy,
                          onChanged: (value) {
                            setState(() {
                              workerIsBusy = value;
                            });
                            DB.db.updateData(
                                Worker(
                                  id: worker.id,
                                  name: worker.name,
                                  dateTime: worker.dateTime,
                                  phoneNum: worker.phoneNum,
                                  isBusy: (workerIsBusy) ? 1 : 0,
                                ),
                                widget.tableName);
                          },
                        ),
                        const SizedBox(height: 5),
                        // Edit button & delete Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  bool result = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              EditWorkerDataPage(
                                                  id: this
                                                      .workersList[index]
                                                      .id,
                                                  name: this
                                                      .workersList[index]
                                                      .name,
                                                  phoneNum: this
                                                      .workersList[index]
                                                      .phoneNum,
                                                  dateTime: this
                                                      .workersList[index]
                                                      .dateTime,
                                                  tableName: widget.tableName,
                                                  isBusy: this
                                                      .workersList[index]
                                                      .isBusy)));
                                  if (result == true) {
                                    updateListView();
                                  }
                                },
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            const SizedBox(width: 10),
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  database.deleteData(
                                      this.workersList[index].id,
                                      widget.tableName);
                                  updateListView();
                                },
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
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
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add Data"),
        onPressed: () async {
          bool backResult = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  AddWorkerDataPage(tableName: widget.tableName)));
          if (backResult == true) {
            updateListView();
            // await notelist();
          }
        },
      ),
    );
  }

  updateListView() {
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
