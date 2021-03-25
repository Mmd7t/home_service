import 'package:flutter/material.dart';
import 'package:home_service/inherited_widgets/theme_changer.dart';
import 'package:home_service/models/worker.dart';
import 'package:home_service/db/db.dart';
import 'package:home_service/widgets/common_appbar.dart';
import 'package:sqflite/sqflite.dart';
import '../../constants.dart';

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
                  return InkWell(
                    onTap: () {},
                    child: Container(
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
                          Text('Name ::    ${worker.name}'),
                          const SizedBox(height: 5),
                          Text('Price in Day ::    ${worker.phoneNum}'),
                          const SizedBox(height: 5),
                          Text('Price in Month ::    ${worker.dateTime}'),
                          const SizedBox(height: 5),
/*----------------------------------------------------------------------------------------------------*/
/*---------------------------------------  Edit & Delete Part  ---------------------------------------*/
/*----------------------------------------------------------------------------------------------------*/
                        ],
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
