import 'package:flutter/material.dart';
import 'package:home_service/models/worker.dart';
import 'package:home_service/db/db.dart';

class AddWorkerDataPage extends StatefulWidget {
  final String tableName;

  const AddWorkerDataPage({Key key, @required this.tableName})
      : super(key: key);
  @override
  _AddWorkerDataPageState createState() => _AddWorkerDataPageState();
}

class _AddWorkerDataPageState extends State<AddWorkerDataPage> {
  TextEditingController nameCon, phoneNumCon, dateTimeCon;
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    phoneNumCon = TextEditingController();
    nameCon = TextEditingController();
    dateTimeCon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Worker",
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
/*--------------------------------------------------------------------------------------------*/
/*-----------------------------------  PriceInDay Input --------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  TextFormField(
                    controller: nameCon,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 18),
                      filled: true,
                      fillColor:
                          Theme.of(context).primaryColor.withOpacity(0.2),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please fill in this label';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*----------------------------------  PriceInMonth Input -------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  TextFormField(
                    controller: phoneNumCon,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 18),
                      filled: true,
                      fillColor:
                          Theme.of(context).primaryColor.withOpacity(0.2),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please fill in this label';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*-----------------------------------  PhoneNumber Input -------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  TextFormField(
                    controller: dateTimeCon,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Date Time',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 18),
                      filled: true,
                      fillColor:
                          Theme.of(context).primaryColor.withOpacity(0.2),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please fill in this label';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Exit"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DB.db.insertData(
                                Worker(
                                  name: nameCon.text,
                                  phoneNum: phoneNumCon.text,
                                  dateTime: dateTimeCon.text,
                                  isBusy: 0,
                                ),
                                widget.tableName);
                            Navigator.pop(context, true);
                          }
                        },
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
