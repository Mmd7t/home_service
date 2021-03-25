import 'package:flutter/material.dart';
import 'package:home_service/inherited_widgets/theme_changer.dart';
import 'package:home_service/models/worker.dart';
import 'package:home_service/db/db.dart';
import 'package:home_service/widgets/common_appbar.dart';
import 'package:sqflite/sqflite.dart';
import '../../constants.dart';
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
  List<Worker> rentCarsList;

  @override
  Widget build(BuildContext context) {
    var themeController = ThemeController.of(context);
    if (rentCarsList == null) {
      rentCarsList = [];
      updateListView();
    }
    return Scaffold(
      appBar: const GlobalAppBar(title: 'Workers List'),
      body: FutureBuilder(
          future: database.getAllWorkerData(widget.tableName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Worker worker = snapshot.data[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (themeController.currentTheme == 'dark')
                          ? c1
                          : Theme.of(context).primaryColor.withOpacity(0.3),
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
                        Text('Date Time :  ${worker.isBusy}'),
                        const SizedBox(height: 5),
/*----------------------------------------------------------------------------------------------------*/
/*---------------------------------------  Edit & Delete Part  ---------------------------------------*/
/*----------------------------------------------------------------------------------------------------*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                bool result = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditWorkerDataPage(
                                              id: this.rentCarsList[index].id,
                                              name:
                                                  this.rentCarsList[index].name,
                                              phoneNum: this
                                                  .rentCarsList[index]
                                                  .phoneNum,
                                              dateTime: this
                                                  .rentCarsList[index]
                                                  .dateTime,
                                              tableName: widget.tableName,
                                              isBusy: this
                                                  .rentCarsList[index]
                                                  .isBusy
                                            )));
                                if (result == true) {
                                  updateListView();
                                }
                              },
                              color: Theme.of(context).accentColor,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                database.deleteWorkerData(
                                    this.rentCarsList[index].id,
                                    widget.tableName);
                                updateListView();
                              },
                              color: Theme.of(context).primaryColor,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          bool result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  AddWorkerDataPage(tableName: widget.tableName)));
          if (result == true) {
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
