import 'package:flutter/material.dart';
import 'package:home_service/components/common_textfield.dart';
import 'package:home_service/models/worker.dart';
import 'package:home_service/db/db.dart';

class EditWorkerDataPage extends StatefulWidget {
  final int id;
  final String name;
  final String phoneNum;
  final String dateTime;
  final String tableName;
  final int isBusy;

  const EditWorkerDataPage({
    Key key,
    @required this.id,
    @required this.name,
    @required this.phoneNum,
    @required this.dateTime,
    @required this.tableName,
    @required this.isBusy,
  }) : super(key: key);
  @override
  _EditWorkerDataPageState createState() => _EditWorkerDataPageState();
}

class _EditWorkerDataPageState extends State<EditWorkerDataPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dateTimeController.text = widget.dateTime;
    nameController.text = widget.name;
    phoneNumController.text = widget.phoneNum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Data",
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
                await DB.db.updateWorkerData(
                    Worker(
                      id: widget.id,
                      name: nameController.text,
                      dateTime: dateTimeController.text,
                      phoneNum: phoneNumController.text,
                      isBusy: widget.isBusy,
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
                  CommonTextFormField(
                    controller: nameController,
                    hintText: 'Name',
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*----------------------------------  PriceInMonth Input -------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  CommonTextFormField(
                    controller: phoneNumController,
                    hintText: 'Phone Number',
                  ),
                  const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------*/
/*-----------------------------------  PhoneNumber Input -------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
                  CommonTextFormField(
                    controller: dateTimeController,
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
