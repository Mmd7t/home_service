import 'package:flutter/material.dart';
import 'package:home_service/models/worker.dart';
import 'package:home_service/db/db.dart';
import 'package:home_service/widgets/global_textfield.dart';

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
          "Add Data",
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            color: Theme.of(context).accentColor,
            icon: const Icon(Icons.cancel_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            color: Colors.blueAccent,
            icon: const Icon(Icons.check),
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
          ),
        ],
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
                  GlobalTextFormField(
                    controller: nameCon,
                    hintText: 'Name',
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*----------------------------------  PriceInMonth Input -------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  GlobalTextFormField(
                    controller: phoneNumCon,
                    hintText: 'Phone Number',
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*-----------------------------------  PhoneNumber Input -------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  GlobalTextFormField(
                    controller: dateTimeCon,
                    hintText: 'Date Time',
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
