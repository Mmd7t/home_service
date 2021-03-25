import 'package:flutter/material.dart';
import 'package:home_service/components/common_textfield.dart';
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
                  CommonTextFormField(
                    controller: nameCon,
                    hintText: 'Name',
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*----------------------------------  PriceInMonth Input -------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  CommonTextFormField(
                    controller: phoneNumCon,
                    hintText: 'Phone Number',
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*-----------------------------------  PhoneNumber Input -------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  CommonTextFormField(
                    controller: dateTimeCon,
                    hintText: 'Date Time',
                  ),
                  Row(
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
                            await DB.db.insertWorkerData(
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
