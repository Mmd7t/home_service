import 'package:flutter/material.dart';
import 'package:home_service/models/worker.dart';
import 'package:home_service/database.dart';

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
  var nameController = TextEditingController();
  var dateTimeController = TextEditingController();
  var phoneNumController = TextEditingController();
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
      appBar: AppBar(title: Text("Edit Worker")),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
// name text field
                  TextFormField(
                    controller: nameController,
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
// phone Number text field
                  TextFormField(
                    controller: phoneNumController,
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
// Date Time text field
                  TextFormField(
                    controller: dateTimeController,
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
// exit button & save button
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
                            await MyDatabase.db.updateData(
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
