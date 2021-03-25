class Worker {
  int id;
  String name;
  String phoneNum;
  String dateTime;
  int isBusy;

  Worker({this.id, this.name, this.phoneNum, this.dateTime, this.isBusy});

  Worker.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phoneNum = map['phoneNum'];
    dateTime = map['dateTime'];
    isBusy = map['isBusy'];
  }

  toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNum': phoneNum,
      'dateTime': dateTime,
      'isBusy': isBusy,
    };
  }
}
